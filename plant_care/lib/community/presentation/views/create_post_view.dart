import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../iam/presentation/providers/auth_provider.dart';
import '../../application/providers/post_provider.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  final _formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final speciesController = TextEditingController();
  final tagController = TextEditingController();

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthProvider>();
    final postProvider = context.read<PostProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // TITLE
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // CONTENT
              TextFormField(
                controller: contentController,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // SPECIES
              TextFormField(
                controller: speciesController,
                decoration: const InputDecoration(
                  labelText: "Species",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 16),

              // TAG
              TextFormField(
                controller: tagController,
                decoration: const InputDecoration(
                  labelText: "Tag",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Required" : null,
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: loading
                      ? null
                      : () async {
                    if (!_formKey.currentState!.validate()) return;

                    setState(() => loading = true);
                    print("🔥 USER ID ENVIADO => ${authProvider.currentUser?.id}");

                    final token = authProvider.token;
                    final userId = authProvider.currentUser!.id;

                    final success = await postProvider.createPost(
                      token: token!,        // ⬅️ NECESARIO
                      userId: userId,       // ⬅️ NECESARIO
                      title: titleController.text,
                      content: contentController.text,
                      species: speciesController.text,
                      tag: tagController.text,
                    );


                    setState(() => loading = false);

                    if (success && mounted) {
                      Navigator.pop(context, true);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              postProvider.errorMessage ??
                                  "Error creating post"),
                        ),
                      );
                    }
                  },
                  child: loading
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text("Publish"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
