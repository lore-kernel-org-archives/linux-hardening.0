Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCD148856
	for <linux-hardening@vger.kernel.org>; Sun, 18 Aug 2024 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723998170; cv=none; b=I6hS1eutXD6wCncfDboFLxNmh+p7wvj/rW94pSkIq8nlzpwJV/dVMONhZyMj9Dbe3pF0ekXPsFa0gRpS8FJqw/cViYcXudCTXQ7gOvcTNlu7XbUeodONGfubI+czf8i82cJ10nlbjbKWSSdGY1HfhLHpVvkCucy8NXY/iCCXBJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723998170; c=relaxed/simple;
	bh=O0Tomsdt9hyq4ddPcU6xWCDEapUAnTnG7RN7oUVGAH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EKPeiTwafRZPAAqttR+n9HBQXBYqpm3JrOjSM47hGL4l4u1UYVgKaGjo7KX2sMYbFrRLToNbwAxmGtN79dgInACvhzxeb3MN0mTQLYn1lHEkdM0JEmgvbV/cfapdCBlWsXb390LpghwaXE/JkaVCZ08iLrNSv1lnZxMUgt7LW5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=CjoFcItN; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="CjoFcItN"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f04150796so4257066e87.3
        for <linux-hardening@vger.kernel.org>; Sun, 18 Aug 2024 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1723998166; x=1724602966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sfuxHBlP680vgtK8qXrXclKhcPmCh6xlyBkEgzNuTQ0=;
        b=CjoFcItNKmazg98TWOM1wgZFYhaKj/kriXyMGn6PfGZxC7IyxCVhxHPTdMJATrsPkH
         xu0pFr+zvG09FrZe2pN5SPxil3+xBWT3SpkAf3Jf4nFQMFseEzaAIlExuByf/DHwz51V
         c/y4pYq21hf67EThH1ZgjeJkez3mIXR4DemliBsLUfCTnoVWwAMM38RoVT28OJ76s/RC
         XCBntIdrSsFdePlaEw2qimRrDfxDpPB2sYv+0m6OZuClvZaVu3isAKsq9sPUn12Vlh6G
         gFQGQceHG26/vGVxMUP7KKb9M8hYFm6iwuvyjRWxbQ69OaaCyPRnQ1CfnXui1eizwGw0
         1Vag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723998166; x=1724602966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sfuxHBlP680vgtK8qXrXclKhcPmCh6xlyBkEgzNuTQ0=;
        b=YUtCYdFnmrgpLzs69wsaadTOa6NXawYirDp0i/msnXzqOV4O5P9LnIq+kowveWi9E/
         SxAkrLesxJaDwOpQZ0/MRMs+5b5jzi/IYJwoCk8NaIT4VUp4srlIArfmMk03WThX1xf1
         q2d/JUICLfViAfFxTi2bmB44G1t6Wgi8hUMoSAovE9uR2ehtumCJ+k8JQOy817lQg2pv
         IYoF9cJgs4gkusOMbAOSAUEn0XEEf6lT+oXxqRjbPAp1aUUS+rC8uvjNP1mWjf7N+9Vg
         hCNLKwwCSnkxPqTQgkbgZXrExfMl27Bge/S/4wUIgypy7Lafm/ldzuJI3BtpQJw240Xm
         VG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVvMfAaYkl5nSJJ7pIVS8AzuO7gTsRFYQemZxQBzT9qq4kqQeObJq9zWulwzmt8X16cXgn+0zThkFxNU7nYsBWl7G7cZSPXiNS7mYlJJMBF
X-Gm-Message-State: AOJu0Yw7d7wJ8yFCrn+Qeh5WM1G3vhuo8qZ7VhG7JcJErNk/hajMi4Rl
	7hsmpZ1wZRjTfBXO4mn9ZMKkK8hTnar6bXpnZoiCXOdtQb2Fy8PHY9MWui6Hgb4=
X-Google-Smtp-Source: AGHT+IG0FlrXrynRBqS7PR6AL05ABuN9aUskbcpF7J3EZEawwoUkjNpgWoDPHrN7shW4OfLVO0Umng==
X-Received: by 2002:a05:6512:4020:b0:52c:e5ac:ecd2 with SMTP id 2adb3069b0e04-5331c6e5031mr5316218e87.51.1723998166264;
        Sun, 18 Aug 2024 09:22:46 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-163.dynamic.mnet-online.de. [62.216.208.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838393457asm528231866b.117.2024.08.18.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 09:22:45 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ksmbd: Replace one-element arrays with flexible-array members
Date: Sun, 18 Aug 2024 18:21:37 +0200
Message-ID: <20240818162136.268325-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated one-element arrays with flexible-array members
in the structs copychunk_ioctl_req and smb2_ea_info_req.

There are no binary differences after this conversion.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/smb/server/smb2pdu.c | 4 ++--
 fs/smb/server/smb2pdu.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2df1354288e6..83667cb78fa6 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -4580,7 +4580,7 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	/* single EA entry is requested with given user.* name */
 	if (req->InputBufferLength) {
 		if (le32_to_cpu(req->InputBufferLength) <
-		    sizeof(struct smb2_ea_info_req))
+		    sizeof(struct smb2_ea_info_req) + 1)
 			return -EINVAL;
 
 		ea_req = (struct smb2_ea_info_req *)((char *)req +
@@ -8083,7 +8083,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 			goto out;
 		}
 
-		if (in_buf_len < sizeof(struct copychunk_ioctl_req)) {
+		if (in_buf_len < sizeof(struct copychunk_ioctl_req) + 1) {
 			ret = -EINVAL;
 			goto out;
 		}
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 3be7d5ae65a8..73aff20e22d0 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -194,7 +194,7 @@ struct copychunk_ioctl_req {
 	__le64 ResumeKey[3];
 	__le32 ChunkCount;
 	__le32 Reserved;
-	__u8 Chunks[1]; /* array of srv_copychunk */
+	__u8 Chunks[]; /* array of srv_copychunk */
 } __packed;
 
 struct srv_copychunk {
@@ -370,7 +370,7 @@ struct smb2_file_attr_tag_info {
 struct smb2_ea_info_req {
 	__le32 NextEntryOffset;
 	__u8   EaNameLength;
-	char name[1];
+	char name[];
 } __packed; /* level 15 Query */
 
 struct smb2_ea_info {
-- 
2.46.0

