Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4698366DB7
	for <linux-hardening@vger.kernel.org>; Fri,  6 Mar 2026 06:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778943; cv=none; b=EMYLjbiTc4rdGJCXeLTHqQWSfbnRw/0bey/uPqK3iInpUWHjN5/xczeGi+Uj2L267gwnG6/U4hW6Ie5FdE/fYUJtj4T5NlMHeE+cvHwVuW0yERWbAzZxD8RTPJEWy8GAqh8p/idHYXCGcDGzVgiuPKVYQ72YZd0NqPzo2B2CgOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778943; c=relaxed/simple;
	bh=9cQdIdDbfHBxQdVjl1wma1djHdHSQkCaWml9R0EIOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hb8LD2s2hHNhQng9ame0QYIHNbzbk+a+mP6G+nrDyP5v2cCN0hRK90mNYI/O4UMZzJeRBUkEz3S7YbV7+LN9hN66RZmaG25bp8MRTR/C1cPNu11gyMg43EUE0obNYmMClMwPgdGoAEDLJo22+6x0okMrwI6jCD4vtj+46ygOGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElgVPC8s; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElgVPC8s"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ae56f8776dso35708995ad.3
        for <linux-hardening@vger.kernel.org>; Thu, 05 Mar 2026 22:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772778941; x=1773383741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O00SvXmF1/neLG6bXArW7CD/JczRf42amEzXY9wGYt8=;
        b=ElgVPC8sKDMRj4sc7J22emogY1ycBWQ/bj+kzeMim6SLxqBP6Zj3JTxvi/UZRuwg83
         KT7M9Y2MEjT5Ywz/SNDT+mZt0PIVYcanrtiS7PX5jWABI9cPru8+o5nBqVc+Tg36biaS
         eOnas/+TUq+P1mVyUD8VMwqFzxSjCT0IdSJ5FG8sDeEjaHkQugnZKQCOEZC9fOgmMyaK
         tptdlEydMT6+l/RDj7yG0difu1toTc/rwy5kEOmCckRR77IRLHhDnlKzUkTZN22Ibfd5
         IuHCakZelZeCOwDupwWmx66/PNV7kL7w6DfyNjUsf+mktwu8ZcCG3HXgOGcST+d28fIv
         6ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778941; x=1773383741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O00SvXmF1/neLG6bXArW7CD/JczRf42amEzXY9wGYt8=;
        b=re7QpdxjoF+/8HkRZQvuynG2mNEWtoBUBrBRXeaT9cJ228UMH/V/W3QZpbXzS+JCeP
         uBsofXFKTXG9KrtUgvQYT1BJgCoqXyteKaV7O3o89evgXdT+h3dy/eo5FusMJb42cfR/
         mtEORDV5TK6OtFJ2JgBh2cZz+I1o9ZBXlbJXzOEtJkfbeAzhsOZ6ukNG1hMEW/b9euyV
         CtJvF5gUpeIppJktaHZCIYZH5Nqh4PzeyDnIaOvquAOTmrJgvcDUDCbzGknR/vgSWTuK
         HO02W4qgDNOvh3eNX5MWvbXwkPqE4qj8KYEJLlh0wR2Svmd88okZqvItRUpWjbZRXo8e
         rGcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVd5CeZ6HEN3BWQhDOAdSRbR4UoWIesEPE7g/inFmka3qBYHU05kQ0sllUjGNnxIP9zWomU8bQK+D4X86cYqbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybWwwnEFSievYCgsah1JNJsXXCjJZESxIk0vZ5Qr+ckY0GXSyu
	ksV1iMlKTr7luuSEnrXNPBqVS/kliugWxOEvxvDPIgFL+nh7MPebbXMe
X-Gm-Gg: ATEYQzwLD0lOMkeTweP6HMA8rMcKjGeNafxgMLwRjaG6Gil55aErQ6/Q+yiVzzfr+RL
	XH1daxvaTvtitr+Ag1vp5UmxhtXYJv9ziOmT6iHcfkPN4tRdfa2RMpBU6V7elf8xIZW/TpxvSaI
	Rt9lkoHv2yWyEYUt04jSZotUkofYafbi+VshBXmbISANFb9jErBOxW8Ob/bH3nJEMchWEeyJlT7
	r1Tc6kOfhneT13v9TO+/eXQ7FM/noHoGp/loFLQOOKtytRjDB4yS0/yfjQRxJdkIQKF3n8Vh+5L
	VQXGyHF+1O6Aq/4oecGzfw4EHXnbKdgbtZEq+4P/z++yc9ds1YX6Ska+irRy6xXWWdj33Okyxjj
	84ZaMOO2TVSMd1queHjvqwMUZW4EV9TLsvJaPoLcuGryBH93EpSV8ubV+wsHWDLqlyAgBwPO1iP
	iJnGuT+BHwU5c5mCZUaJ3M/M6GVJOXbjnSFEILV8CqEbsOl9NY9b5DPDo=
X-Received: by 2002:a17:903:46c4:b0:2ae:5063:b3e0 with SMTP id d9443c01a7336-2ae823febb1mr13075235ad.9.1772778941243;
        Thu, 05 Mar 2026 22:35:41 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f752bfsm9788055ad.60.2026.03.05.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:35:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-cifs@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ksmbd: ipc: use kzalloc_flex and __counted_by
Date: Thu,  5 Mar 2026 22:35:22 -0800
Message-ID: <20260306063522.439782-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The former is just a nice macro and the latter allows runtime analysis
of the allocation and its size.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/smb/server/transport_ipc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2dbabe2d8005..f7aa427a06fe 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -55,7 +55,7 @@ static bool ksmbd_ipc_validate_version(struct genl_info *m)
 struct ksmbd_ipc_msg {
 	unsigned int		type;
 	unsigned int		sz;
-	unsigned char		payload[];
+	unsigned char		payload[] __counted_by(sz);
 };
 
 struct ipc_msg_table_entry {
@@ -242,9 +242,8 @@ static void ipc_update_last_active(void)
 static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 {
 	struct ksmbd_ipc_msg *msg;
-	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
+	msg = kvzalloc_flex(*msg, payload, sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
-- 
2.53.0

