Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5873622
	for <linux-hardening@vger.kernel.org>; Thu, 21 Mar 2024 00:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710981538; cv=none; b=Og0vzA01b2o/X1aNJoNLp2fQKn1A+iXpzio4CqeOvSEw7CYw+JbPNEsb8C70A9dC3tzg/+QDIjt6YDxfouzeGYqRgG9721wY4MfJoOnaj3h4sH5KA3IJDtsyxI5608CkIkup0zBRkXNbe+RqcZcUcrDBESkbpQepWioDPK3WJ/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710981538; c=relaxed/simple;
	bh=XWwaocKABQ9jnViAkbtIF/KvUYPFqVLENRHRK/iFWVw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qbcFE60lKepwW37YULrqqEyrySJbvsqbd8wTY73s0QFGJ1yonZ4CPXoc11VRIGm03GUKphHAr/NVLs93bQpTGSxacoZBF9KEw+L3VbvVJEzORB84/8JVzxQD3QCxL613GydkanwzDuQJlYkXYtP8Y9R5ixZi74k+7JRQRdzblwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0GtVs/JL; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0GtVs/JL"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd944567b6cso527211276.2
        for <linux-hardening@vger.kernel.org>; Wed, 20 Mar 2024 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710981535; x=1711586335; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xiemHHBtoyDT5DKRZLV0lQm6JsJHIMbODJolPo371hM=;
        b=0GtVs/JLnLnnGCIDQ2qGKDedgaMNKmIQH7DjYxwn9Id400GFYwtuK6MZOwUORA115W
         NNkdpHF4H22iB0Ok0g/Lxk6IC1f+C8Dfjv8NRYiLS0ZNBRAz9rH7XNKtPhz7/lDNXay4
         fV16qY/90Zze9qPCZnq2ciWtyoLC8wHUv/DpVM7YGqq6Oahj5t3In26GN9+H280uCO1I
         f9zgtM1TaVhA54TUqNv8Dv6CoMPOncDUKymwBB1bJcwGrE+mAwuuxPQvkRblk6FrXJFb
         jSfIe5u7UFc1qqGMsfVi0CesYaz1Zokprb//zr95dEkWNitTCFNwEs1jKy8CQePh6ZkL
         LIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710981535; x=1711586335;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xiemHHBtoyDT5DKRZLV0lQm6JsJHIMbODJolPo371hM=;
        b=sB1h++w6Edh16i5oo6to0KxDB02OLudxMS6Ix9tHirw/TSAzPF27KUvsSur42g4gae
         jZPFCO+5FyS2mjXopRsHQby4kM1X0faul6/ri9D23Q0yq51trlXI0o+Vo1cAtFcmfukC
         Xi6bRzYRpkGQXVY/gQDCGXsER6XjjX28N9L+My0bLoL/CJsnCyvKdacRu0JXZBWfs613
         lQXHtI8w1VBcTjTsDCtLZmPCOzkd006UGGxwrmE+On/uw/VqwPsczGQA61sfnNtE5iIr
         8LSr4/6g0m3Tak+6XOpQQJXwrunNtAx1CR7BWuOpRuK8teJCDMndRK/DwmdK5/9lExJW
         scLg==
X-Forwarded-Encrypted: i=1; AJvYcCXeKt1Ij4xBEx2YeSKm4H7JXaUW4JMdAnDA/TKSPj0/MF5XPcylUlfRx+zd88FNPX/VPVtvdL7/Y+czo7oUdmyA8owowAmBk9dIA1WNx+I0
X-Gm-Message-State: AOJu0YzyD+GveXYavS6IcrpOsYI38Q8i0N222yGSdnJyPzBRufMrqqW6
	w+udLjpQld30rGhmu7a5SeNwzeUSEpGgh5I3/h5vHWFu2pal3s0+mTlfWKFmXD3OWWtsYcNL/uF
	hz6ncinDHdz+oktV0cVp/Jw==
X-Google-Smtp-Source: AGHT+IEyZS/GnFbBPsZmSMZkiLLZnAAkx4UzmIWqrQdpodEes9mL4Gqf1zabfr+eMBwIO+azPp4WMHvsfJ63gPdLdQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:160c:b0:dd9:20fb:20a1 with
 SMTP id bw12-20020a056902160c00b00dd920fb20a1mr563186ybb.10.1710981535047;
 Wed, 20 Mar 2024 17:38:55 -0700 (PDT)
Date: Thu, 21 Mar 2024 00:38:54 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAJ2B+2UC/x2Muw6DMAwAfwV5rqU8YCi/gjqkxqFekshGVRHi3
 xsx3d1yJxirsME8nKD8FZNaevjHAPRJZWOUtTcEF0YXg0fbtVA7MBsy6dH2LjcrEqbp+Y6UXYp E0BdNOcvv3i+v6/oDnEyEKm4AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710981534; l=4760;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=XWwaocKABQ9jnViAkbtIF/KvUYPFqVLENRHRK/iFWVw=; b=ZcTTtdciSPEfO0FzGxDVut7rB4NJpxOIDpSNKacGuqw0E9oZmdCWm78ES7wtKmtQt5C/hBbkh
 Fj1g6RGbhumCW9AxyrArhailPRTKc7ssmywSffs/q8IMdUh7wG3Yxvk
X-Mailer: b4 0.12.3
Message-ID: <20240321-strncpy-fs-ecryptfs-crypto-c-v1-1-d78b74c214ac@google.com>
Subject: [PATCH] fs: ecryptfs: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Tyler Hicks <code@tyhicks.com>
Cc: ecryptfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is deprecated for use on NUL-terminated destination strings
[1] and as such we should prefer more robust and less ambiguous string
interfaces. A good alternative is strscpy() as it guarantees
NUL-termination on the destination buffer.

In crypto.c:
We expect cipher_name to be NUL-terminated based on its use with
the C-string format specifier %s and with other string apis like
strlen():
|	printk(KERN_ERR "Error attempting to initialize key TFM "
|		"cipher with name = [%s]; rc = [%d]\n",
|		tmp_tfm->cipher_name, rc);
and
|	int cipher_name_len = strlen(cipher_name);

In main.c:
We can remove the manual NUL-byte assignments as well as the pointers to
destinations (which I assume only existed to trim down on line length?)
in favor of directly using the destination buffer which allows the
compiler to get size information -- enabling the usage of the new
2-argument strscpy().

Note that this patch relies on the _new_ 2-argument versions of
strscpy() and strscpy_pad() introduced in Commit e6584c3964f2f ("string:
Allow 2-argument strscpy()").

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/ecryptfs/crypto.c |  4 +---
 fs/ecryptfs/main.c   | 26 ++++++--------------------
 2 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index 2fe0f3af1a08..d39a1a69fecc 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1606,9 +1606,7 @@ ecryptfs_add_new_key_tfm(struct ecryptfs_key_tfm **key_tfm, char *cipher_name,
 		goto out;
 	}
 	mutex_init(&tmp_tfm->key_tfm_mutex);
-	strncpy(tmp_tfm->cipher_name, cipher_name,
-		ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-	tmp_tfm->cipher_name[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+	strscpy(tmp_tfm->cipher_name, cipher_name);
 	tmp_tfm->key_size = key_size;
 	rc = ecryptfs_process_key_cipher(&tmp_tfm->key_tfm,
 					 tmp_tfm->cipher_name,
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 2dc927ba067f..577c56302314 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -256,11 +256,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 	substring_t args[MAX_OPT_ARGS];
 	int token;
 	char *sig_src;
-	char *cipher_name_dst;
 	char *cipher_name_src;
-	char *fn_cipher_name_dst;
 	char *fn_cipher_name_src;
-	char *fnek_dst;
 	char *fnek_src;
 	char *cipher_key_bytes_src;
 	char *fn_cipher_key_bytes_src;
@@ -293,12 +290,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 		case ecryptfs_opt_cipher:
 		case ecryptfs_opt_ecryptfs_cipher:
 			cipher_name_src = args[0].from;
-			cipher_name_dst =
-				mount_crypt_stat->
-				global_default_cipher_name;
-			strncpy(cipher_name_dst, cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			cipher_name_dst[ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(mount_crypt_stat->global_default_cipher_name,
+				cipher_name_src);
 			cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_ecryptfs_key_bytes:
@@ -326,11 +319,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			break;
 		case ecryptfs_opt_fnek_sig:
 			fnek_src = args[0].from;
-			fnek_dst =
-				mount_crypt_stat->global_default_fnek_sig;
-			strncpy(fnek_dst, fnek_src, ECRYPTFS_SIG_SIZE_HEX);
-			mount_crypt_stat->global_default_fnek_sig[
-				ECRYPTFS_SIG_SIZE_HEX] = '\0';
+			strscpy(mount_crypt_stat->global_default_fnek_sig,
+				fnek_src);
 			rc = ecryptfs_add_global_auth_tok(
 				mount_crypt_stat,
 				mount_crypt_stat->global_default_fnek_sig,
@@ -348,12 +338,8 @@ static int ecryptfs_parse_options(struct ecryptfs_sb_info *sbi, char *options,
 			break;
 		case ecryptfs_opt_fn_cipher:
 			fn_cipher_name_src = args[0].from;
-			fn_cipher_name_dst =
-				mount_crypt_stat->global_default_fn_cipher_name;
-			strncpy(fn_cipher_name_dst, fn_cipher_name_src,
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE);
-			mount_crypt_stat->global_default_fn_cipher_name[
-				ECRYPTFS_MAX_CIPHER_NAME_SIZE] = '\0';
+			strscpy(mount_crypt_stat->global_default_fn_cipher_name,
+				fn_cipher_name_src);
 			fn_cipher_name_set = 1;
 			break;
 		case ecryptfs_opt_fn_cipher_key_bytes:

---
base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
change-id: 20240321-strncpy-fs-ecryptfs-crypto-c-a59b3cf0a3cc

Best regards,
--
Justin Stitt <justinstitt@google.com>

