SELECT
posts.id as post_id,
(
    to_tsvector('english', coalesce(posts.text, ''))
) AS tsv_document
FROM posts

