import re

with open('lib/Home/EditScreen.dart', 'r') as f:
    content = f.read()

# 1. Wrap Stack in ScrollConfiguration + SingleChildScrollView
# Find the start of the Stack
content = content.replace(
    "body:Stack(",
    """body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Stack("""
)

# 2. Remove the old ScrollConfiguration and SingleChildScrollView
# The original code has:
#                 Expanded(
#                     child: ScrollConfiguration(
#                         behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
#                         child: SingleChildScrollView(
#                             physics: const ClampingScrollPhysics(),
#                         child: Container(
#                           width: double.infinity,
#                           height: 830,

old_scroll = """                Expanded(
                    child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context).copyWith(overscroll: false),
                        child: SingleChildScrollView(
                            physics: const ClampingScrollPhysics(),
                        child: Container(
                          width: double.infinity,
                          height: 830,
                          child: Column("""

new_scroll = """                Container(
                  width: double.infinity,
                  child: Column("""

content = content.replace(old_scroll, new_scroll)

# 3. Remove the trailing parentheses for the removed Expanded, ScrollConfiguration, SingleChildScrollView
# At the bottom, there is:
#                         )
#                     ),
#                     ),
#                 ),
#
#               ],
#             )
#           )
#
#         ],
#       ),
#     );

old_bottom = """                        )
                    ),
                    ),
                ),

              ],
            )
          )

        ],
      ),"""

new_bottom = """              ],
            )
          )

        ],
      ),
      ),
      ),"""

content = content.replace(old_bottom, new_bottom)

with open('lib/Home/EditScreen.dart', 'w') as f:
    f.write(content)

print("Done")
