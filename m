Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6C115216E
	for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 21:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711573857; cv=none; b=TSgya+sx3KA/ud76q8yS9OUcpfLXkKPW01MXyUhCt/zYrl91hjZr6bEnk2y9umtZoG+7umxkjxCp+Wd8SJC5EnCCEJdUoEaRRPKWxbw6KBvDIAx8P8WUc7WjcicAfMt15Ii10uvng4xRB2fZegCDTMFeI89GCyOQlQ8xj97e6Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711573857; c=relaxed/simple;
	bh=c05JlIhAAX9+Wj5KD5xjyuKpqsfoj6wU7p1hNY3Smz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OkmLUajPxpwK2fL97XJsS2A5PSlPSjEKkyVy/qrHM9OJAQIBgTeXysGGkU7xshmXLWo7lW0J84TvJ+jlWSRWqBUfZdOb4OeFtiRbH7afR+CvyRNchc50Yj5Bt2iqhjO1JxXJz1YXo3X9pKnJvFa+2jHKacQPruJOb58RZ696Tps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCC4+8dH; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCC4+8dH"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a54004e9fso5413117b3.3
        for <linux-hardening@vger.kernel.org>; Wed, 27 Mar 2024 14:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711573854; x=1712178654; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+lkMVelOezh/ZlXJ0pLzE+PWawOJ1uDpRCeivCwpFfI=;
        b=zCC4+8dHmu7g+yxnAfrpQsbDO5BHPpXJUZ/FK2Ram9W0bPkgiy6lD/F8KpefMF9lSy
         h+v9xECyTVaZpsgaKtt5OUDBdU6rmh9dM8aioG/g1oMTuBMCAAunVmijbTgBRZ/B0pII
         xZJ29flVen8ogc1E3pr3oGyMs5YIOm8qAk8t82nyaOHcVsdV0mmMrFKz/T9yrDdxRSuB
         ZyFkoXxuVP21iK5fK+vQVMEbD3QBsVQ0eTjhe8b47waFEp0kwjd6O1mIt+lUa04D+w1z
         +79sCD06feWD7N8ghE+r2f5QwbkybVfcjaMJkIhWum3pAi58UjHzoQ/1qaldiDJ0KxX6
         OR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711573854; x=1712178654;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+lkMVelOezh/ZlXJ0pLzE+PWawOJ1uDpRCeivCwpFfI=;
        b=Iw6ZTG9jdfJ1J8nbq82pKk/nPI3NyrtSNnMazNTFBwJJxzGtDvtqSTdvylVhEXqFDv
         cNOD7IcaioV6xSBtELUc1iA8f63aoOaaogEsJ3AvqiG0i0Im7FfMELfby8phMQUWG6So
         xr9Tmzix0ua3sz3lT8GYeNunJ6szjCN/SPom8/Leh08IUsonFiyId7rSiEvmm5Tw4zs8
         2bLshkE4KQqVPbAPKh86qJcrK4uf5BdEGddmZffup9ihPp1tXH18bS03KW9A0RWbQz1z
         VH5l66p+mr7eXBx8IMmw+HP56ePjkXtRuzq8MzI8jfkoivUqf4NRyXTUjqg/59qvoTzf
         Wylg==
X-Forwarded-Encrypted: i=1; AJvYcCV8lI/ogr7cEoMKBy78JBsevGKViE636DMvCWBkP4W5f9IsqUCJ9DU1fSNu+w4Ev/QtSbnXqRuQ72z1QLj/H2KnWFNQbsnB9/LyfbYnJXfc
X-Gm-Message-State: AOJu0YzrfizJGWKKk+6WgPsoEnEpeeJK/lGDu3Uj1/hxR43TBQ1chBEC
	MuSbhsWoFYDMeQiGl6dlm4aCMm7zLarlEwBElCifLt8sMc/r1M+UEpPtIsjFBk13h3zLxoWWS3a
	/Yu9sk6f35RmOUcIWYTmG9A==
X-Google-Smtp-Source: AGHT+IF2W4CfyY1W2KI8dpvyaTKLJ22XNKhwxs5DcbfYiSRg/rNYQ2xBm+UlXjsQKvrjcxKStDc5WbID/PhFU2jObA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:1009:b0:dc6:ff2b:7e1b with
 SMTP id w9-20020a056902100900b00dc6ff2b7e1bmr325202ybt.4.1711573854514; Wed,
 27 Mar 2024 14:10:54 -0700 (PDT)
Date: Wed, 27 Mar 2024 21:10:52 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAFuLBGYC/x3MwQqDMAyA4VeRnA3YTqb4KuLBxXTLYW1JpCjiu
 6/s+B3+/wJjFTaYmguUi5ikWOHaBuizxjejbNXgO993Dz+g7RopnxgMsybC8qWkjIQvN27D0wV eOUDNs3KQ47+el/v+AZI+IAhqAAAA
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711573853; l=2631;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=c05JlIhAAX9+Wj5KD5xjyuKpqsfoj6wU7p1hNY3Smz4=; b=dvoo077PNzidPJkbn13FOfdETuWck8T+nbUCWDn79wP+pUbOIiqdMGPeDBqCc5kqKPcrChbca
 T5lNI9lENkhAMdr88HffzjhBqJSvVobkKfzQHKHkcprOU1eF+49l098
X-Mailer: b4 0.12.3
Message-ID: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com>
Subject: [PATCH] vmcore: replace strncpy with strtomem
From: Justin Stitt <justinstitt@google.com>
To: Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>
Cc: kexec@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

strncpy() is in the process of being replaced as it is deprecated in
some situations [1]. While the specific use of strncpy that this patch
targets is not exactly deprecated, the real mission is to rid the kernel
of all its uses.

Looking at vmcoredd_header's definition:
|	struct vmcoredd_header {
|		__u32 n_namesz; /* Name size */
|		__u32 n_descsz; /* Content size */
|		__u32 n_type;   /* NT_VMCOREDD */
|		__u8 name[8];   /* LINUX\0\0\0 */
|		__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
|	};
... we can see that both `name` and `dump_name` are u8s. It seems `name`
wants to be NUL-padded (based on the comment above), but for the sake of
symmetry lets NUL-pad both of these.

Mark these buffers as __nonstring and use strtomem_pad.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Note: build-tested only.

Found with: $ rg "strncpy\("
---
 fs/proc/vmcore.c            | 5 ++---
 include/uapi/linux/vmcore.h | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
index 1fb213f379a5..5d7ecf3b75e8 100644
--- a/fs/proc/vmcore.c
+++ b/fs/proc/vmcore.c
@@ -1370,9 +1370,8 @@ static void vmcoredd_write_header(void *buf, struct vmcoredd_data *data,
 	vdd_hdr->n_descsz = size + sizeof(vdd_hdr->dump_name);
 	vdd_hdr->n_type = NT_VMCOREDD;
 
-	strncpy((char *)vdd_hdr->name, VMCOREDD_NOTE_NAME,
-		sizeof(vdd_hdr->name));
-	memcpy(vdd_hdr->dump_name, data->dump_name, sizeof(vdd_hdr->dump_name));
+	strtomem_pad(vdd_hdr->name, VMCOREDD_NOTE_NAME, 0);
+	strtomem_pad(vdd_hdr->dump_name, data->dump_name, 0);
 }
 
 /**
diff --git a/include/uapi/linux/vmcore.h b/include/uapi/linux/vmcore.h
index 3e9da91866ff..7053e2b62fa0 100644
--- a/include/uapi/linux/vmcore.h
+++ b/include/uapi/linux/vmcore.h
@@ -11,8 +11,8 @@ struct vmcoredd_header {
 	__u32 n_namesz; /* Name size */
 	__u32 n_descsz; /* Content size */
 	__u32 n_type;   /* NT_VMCOREDD */
-	__u8 name[8];   /* LINUX\0\0\0 */
-	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES]; /* Device dump's name */
+	__u8 name[8] __nonstring;   /* LINUX\0\0\0 */
+	__u8 dump_name[VMCOREDD_MAX_NAME_BYTES] __nonstring; /* Device dump's name */
 };
 
 #endif /* _UAPI_VMCORE_H */

---
base-commit: 928a87efa42302a23bb9554be081a28058495f22
change-id: 20240327-strncpy-fs-proc-vmcore-c-b18d761feaef

Best regards,
--
Justin Stitt <justinstitt@google.com>

