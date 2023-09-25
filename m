Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3652D79D3
	for <linux-hardening@vger.kernel.org>; Mon, 25 Sep 2023 06:13:15 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15751CE
	for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 23:13:14 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59c240e637aso110983567b3.3
        for <linux-hardening@vger.kernel.org>; Sun, 24 Sep 2023 23:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695622393; x=1696227193; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ycLbAEGjG2OMuy7bZZ7q2QOiJ4YnfeodCoeJEwU0Jy0=;
        b=emMf1ESr+ZMjNloPET7NAoN3extdIhgNNDOMvcdrMVUuZMcImaS2Mov8VeBhKjrSrk
         T2f0nKiscEkEQuh0X/cxg9hmqS7lB08UyRUeoQqQ2u7f6r/6WreMfDTvCetZtESv+uqW
         qscj1jEK01BNdx1I6pDKZdxyf8SWZWJMecnCOmJPkoU0N4Ac/UfmwIk0o/v7J9924c+h
         d/BLEvawybeZgDhfAf7ead2FmhqZFsznWd0pEXzi1fnQcbvsSjTZRbeq0DziIwmS7P5U
         svn+t+rai2SPgnANbMHDtqRJ+qqKN/ZFKoHKpfuEJmCH1raeOLUfHZSYf/qEriqFKwFj
         V1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695622393; x=1696227193;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ycLbAEGjG2OMuy7bZZ7q2QOiJ4YnfeodCoeJEwU0Jy0=;
        b=BJP1mm7LqwklmQ5jzvOVp0g3gnMy1n9FjBBSXjFXTVA2JZxzAk/UPPczVSBHoJWPcI
         A0D1TFgfy9rFc8+hMuAPcEdjNju01mUbmWSdOycLFT0gSVmfXAOFXBvfyY2cXXzOHKxd
         MbX9/UtTlQ/QglZfAGCb8+/wSVRkigUc2jL/dn2oHHKY8+NqnvttWreavQgrSYN9Ob4u
         6E2P7Cn77VJ9hwJ2jSD/WSw2cwM2kjuD93+InvUlLat4qhxAsl9QWbvTg4Iwt/87yVr9
         Rpvm/hUfOA/dr/5nbqBJGxPXRXqGKsRFHR1HERbO6YxvJR6o5SlCF6axzzq4X28mX3YE
         leDA==
X-Gm-Message-State: AOJu0YyO593qRQcG2gAyxMs7SHH10fjhDCRQFFUSIUV6IAtpDz/g7e9g
	GsFcHzGgBVlK7I0TVIj6LCPFPTXaYyL+kNh8KA==
X-Google-Smtp-Source: AGHT+IHmy3ncfol/vhb3VkS3Sr/f9jVGajGoTvPFAixf96EbbJPo5Lv4/55OBM836+Q51hnkLnTJ2pEswZHgOcDVaw==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a81:4525:0:b0:59b:e1db:5633 with SMTP
 id s37-20020a814525000000b0059be1db5633mr62368ywa.1.1695622393329; Sun, 24
 Sep 2023 23:13:13 -0700 (PDT)
Date: Mon, 25 Sep 2023 06:13:12 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPckEWUC/x3NwQrCMAyA4VcZORuoHVPnq4iHkGQuh9aRljEZe
 /cVj9/l/3co6qYFnt0OrqsV++aG66UDnil/FE2aIYbYhzEOWKpnXn4obqt6wSQoCZl4VkxaSag SMk738AjjTQaJEVpscZ1s+49e7+M4AWGjYUx4AAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1695622392; l=3897;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=L9/fdUPf3xhTtPuNBdXSMdi4yA/i8QBeE3Azuo4x1V4=; b=s7K9oW+wn0ijUhrySteAlkbaAM8X5C4rkp3jki9seVEy0xY+hLk287rA8MGz9tW8TbMwZetUm
 /4fAXWdPvzQAg+tYrQ200y/X9gvS7KkXrTc3YzrqfbEeKZlVPYYe+Tj
X-Mailer: b4 0.12.3
Message-ID: <20230925-strncpy-drivers-md-dm-cache-metadata-c-v1-1-4b75c7db0cfe@google.com>
Subject: [PATCH] dm cache metadata: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

`strncpy` is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces.

It seems `cmd->policy_name` is intended to be NUL-terminated based on a
now changed line of code from Commit (c6b4fcbad044e6ff "dm: add cache
target"):
|       if (strcmp(cmd->policy_name, policy_name)) { // ...

However, now a length-bounded strncmp is used:
|       if (strncmp(cmd->policy_name, policy_name, sizeof(cmd->policy_name)))
... which means NUL-terminated may not strictly be required. However, I
believe the intent of the code is clear and we should maintain
NUL-termination of policy_names.

Moreover, __begin_transaction_flags() zero-allocates `cmd` before
calling read_superblock_fields():
|       cmd = kzalloc(sizeof(*cmd), GFP_KERNEL);

Also, `disk_super->policy_name` is zero-initialized
|       memset(disk_super->policy_name, 0, sizeof(disk_super->policy_name));
... therefore any NUL-padding is redundant.

Considering the above, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.
---
 drivers/md/dm-cache-metadata.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-cache-metadata.c b/drivers/md/dm-cache-metadata.c
index acffed750e3e..5a18b80d3666 100644
--- a/drivers/md/dm-cache-metadata.c
+++ b/drivers/md/dm-cache-metadata.c
@@ -597,7 +597,7 @@ static void read_superblock_fields(struct dm_cache_metadata *cmd,
 	cmd->discard_nr_blocks = to_dblock(le64_to_cpu(disk_super->discard_nr_blocks));
 	cmd->data_block_size = le32_to_cpu(disk_super->data_block_size);
 	cmd->cache_blocks = to_cblock(le32_to_cpu(disk_super->cache_blocks));
-	strncpy(cmd->policy_name, disk_super->policy_name, sizeof(cmd->policy_name));
+	strscpy(cmd->policy_name, disk_super->policy_name, sizeof(cmd->policy_name));
 	cmd->policy_version[0] = le32_to_cpu(disk_super->policy_version[0]);
 	cmd->policy_version[1] = le32_to_cpu(disk_super->policy_version[1]);
 	cmd->policy_version[2] = le32_to_cpu(disk_super->policy_version[2]);
@@ -707,7 +707,7 @@ static int __commit_transaction(struct dm_cache_metadata *cmd,
 	disk_super->discard_block_size = cpu_to_le64(cmd->discard_block_size);
 	disk_super->discard_nr_blocks = cpu_to_le64(from_dblock(cmd->discard_nr_blocks));
 	disk_super->cache_blocks = cpu_to_le32(from_cblock(cmd->cache_blocks));
-	strncpy(disk_super->policy_name, cmd->policy_name, sizeof(disk_super->policy_name));
+	strscpy(disk_super->policy_name, cmd->policy_name, sizeof(disk_super->policy_name));
 	disk_super->policy_version[0] = cpu_to_le32(cmd->policy_version[0]);
 	disk_super->policy_version[1] = cpu_to_le32(cmd->policy_version[1]);
 	disk_super->policy_version[2] = cpu_to_le32(cmd->policy_version[2]);
@@ -1726,7 +1726,7 @@ static int write_hints(struct dm_cache_metadata *cmd, struct dm_cache_policy *po
 	    (strlen(policy_name) > sizeof(cmd->policy_name) - 1))
 		return -EINVAL;
 
-	strncpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
+	strscpy(cmd->policy_name, policy_name, sizeof(cmd->policy_name));
 	memcpy(cmd->policy_version, policy_version, sizeof(cmd->policy_version));
 
 	hint_size = dm_cache_policy_get_hint_size(policy);

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20230925-strncpy-drivers-md-dm-cache-metadata-c-f708096d5d22

Best regards,
--
Justin Stitt <justinstitt@google.com>

