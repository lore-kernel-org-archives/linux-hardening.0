Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882841AA3FF
	for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722377011; cv=none; b=c0WvX1fm2eONF+A+Qyj6AWkMKw/d7DqMOcL+zlk97TLX0oY1V0UWyBl8v/qtvQddAMM56OI0XlkBadaja6UliH22MNKYrK52WrXSzCUHKlmbXfZbAXBd6bqICcZeCWL/DUFU4dsnx8Xfk/zucG5aWMRUK/HO/QnuT/VSJUTfTUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722377011; c=relaxed/simple;
	bh=T6XB/UxIt5ahppozx8cDvdlnzxM96xFJq46yS1oHwxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nuMdUrJpX2fKk0rAVczkFMrAeFnpFixqTcxouJFSWuxsy4rQiMN8UQulFpm4MvYE/2ryAo7wCaSnWCXQgrSPVfvhfK3eUfTYuCUauzKUtQ8L3Oe3UpYazlOvJhDm49jUIFtv55UFAGdlzn0QpLAl5UiitQSITA6vFtJZg69Zu/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=XUGRRXTe; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="XUGRRXTe"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a8a4f21aeso667547966b.2
        for <linux-hardening@vger.kernel.org>; Tue, 30 Jul 2024 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722377008; x=1722981808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cQd/qUCzd98DKMhZGAyQi0AZAIe2ySF7lmegpNpJvqc=;
        b=XUGRRXTeU1hL1DdBy2M+mloNrJA1m2bJuJyuLXk+J+pMs71vhkLShuZ3xGs9d89DEk
         idm7UzxDujupV30MAS7g0j32doxNoIfXULDUrG+nHU/ttt+QDykK7p9jWOUHnK+14h9I
         HghJ5sqcmvCzllwq/UxoWudQ+OKSoeZrQsbkbrA6ug4MCbV1kIDg61Foa0y4F3pT+AG2
         Jm3kGoV7r+Xoym411/SjvDdgs1q/HkRPJ+CV9njgOZD2W6lU6mQMtelR5kQeEmYWmKz9
         iQnF8LbK+gpq5G+iVj4iRGktbehVrlMU+qmVhcKvCo23sAG1zy1yHHGtRdgNjCQOIqbT
         Pp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722377008; x=1722981808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQd/qUCzd98DKMhZGAyQi0AZAIe2ySF7lmegpNpJvqc=;
        b=rSE3sL/uNfBySsG7K29gPuzjwnKz3EhRahtmfAhffCCMOU47CO593R/kRsfw+qvAHb
         KvBrzo8LTqo6MZij0Dw7xc3pcW6IM8IIaE/6jTc9IihhGUIOfFfBRAVQcYGl7NQBIaWi
         ZVNWdHSvi5ahGpxGNQc4jnzYQB0SL0OWPtcUquIQpCJmArVyIKynA6mW7L/7rNgCYYun
         QU9pn8bGFEGMxH7rOjc9P08M6qUqv1luMvaVg02MHGrNXXW/h3C/YCx5l0jagdpImbcD
         NMLuRxdH+objAk0Do7y4T8iYNDixBrxPgvjGhOgHl4nJJxBMBEC8kPg9BO9XZIq8srWG
         8eYA==
X-Forwarded-Encrypted: i=1; AJvYcCUaeiue5tWHrM61s3UkNcGBgItvikHwK7l5zTCB3MCzON3m0zWMrGuPimIx9kve26spoztKpIAR6db9HLsz8t0FhcnT21hIRTH9E8QOAXXb
X-Gm-Message-State: AOJu0YzN9GVnHbMTfx5DyE1F6Sek0KPELeBPE5ckFM/4nEah3/cNwUb/
	C6OFmXE450IOiruKEp6IVX73aGYR0PTOKZsxtoPDL6nhUi10K2iL1BQdzaLpa1g=
X-Google-Smtp-Source: AGHT+IF1gaydBCbdkb+0mIKJs7r3iiV7SXsmmw8DHjaqfSQT0GzXJ1xKgEKeQAvKNKhSYoY+VfmB+A==
X-Received: by 2002:a17:907:6d25:b0:a7d:34fd:6cd0 with SMTP id a640c23a62f3a-a7d4015fca8mr902016966b.66.1722377007402;
        Tue, 30 Jul 2024 15:03:27 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acadb9819sm691401966b.205.2024.07.30.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 15:03:27 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v4] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Wed, 31 Jul 2024 00:02:02 +0200
Message-ID: <20240730220200.410939-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

In ext4_expand_inode_array(), use struct_size() instead of offsetof()
and remove the local variable count. Increment the count field before
adding a new inode to the inodes array.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
- Use struct_size() and struct_size_t() instead of offsetof()
- Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/

Changes in v3:
- Use struct_size() instead of struct_size_t() as suggested by Kees Cook
- Remove the local variable count as suggested by Gustavo A. R. Silva
- Increment count before adding a new inode as suggested by Gustavo
- Link to v2: https://lore.kernel.org/linux-kernel/20240730172301.231867-4-thorsten.blum@toblux.com/

Changes in v4:
- Remove unnecessary count assignment and adjust copying the whole
  struct as suggested by Gustavo
- Link to v3: https://lore.kernel.org/linux-kernel/20240730205509.323320-3-thorsten.blum@toblux.com/
---
 fs/ext4/xattr.c | 22 ++++++++++------------
 fs/ext4/xattr.h |  4 ++--
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..263567d4e13d 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2879,33 +2879,31 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 	if (*ea_inode_array == NULL) {
 		/*
 		 * Start with 15 inodes, so it fits into a power-of-two size.
-		 * If *ea_inode_array is NULL, this is essentially offsetof()
 		 */
-		(*ea_inode_array) =
-			kmalloc(offsetof(struct ext4_xattr_inode_array,
-					 inodes[EIA_MASK]),
-				GFP_NOFS);
+		(*ea_inode_array) = kmalloc(
+			struct_size(*ea_inode_array, inodes, EIA_MASK),
+			GFP_NOFS);
 		if (*ea_inode_array == NULL)
 			return -ENOMEM;
 		(*ea_inode_array)->count = 0;
 	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
 		/* expand the array once all 15 + n * 16 slots are full */
 		struct ext4_xattr_inode_array *new_array = NULL;
-		int count = (*ea_inode_array)->count;
 
-		/* if new_array is NULL, this is essentially offsetof() */
 		new_array = kmalloc(
-				offsetof(struct ext4_xattr_inode_array,
-					 inodes[count + EIA_INCR]),
-				GFP_NOFS);
+			struct_size(*ea_inode_array, inodes,
+				    (*ea_inode_array)->count + EIA_INCR),
+			GFP_NOFS);
 		if (new_array == NULL)
 			return -ENOMEM;
 		memcpy(new_array, *ea_inode_array,
-		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
+		       struct_size(*ea_inode_array, inodes,
+				   (*ea_inode_array)->count));
 		kfree(*ea_inode_array);
 		*ea_inode_array = new_array;
 	}
-	(*ea_inode_array)->inodes[(*ea_inode_array)->count++] = inode;
+	(*ea_inode_array)->count++;
+	(*ea_inode_array)->inodes[(*ea_inode_array)->count - 1] = inode;
 	return 0;
 }
 
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2

