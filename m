Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA92614831D
	for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 23:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708126148; cv=none; b=t3slpQQd8G/q50Ox1L1DIezhwec1llgFp5kAFEMDT1WObyLycU3Cu0BhV1PwomNQh7VoAWmlaAIJlgtP3oJ5qSX6LNvMrzxfLCQHiMJjzvcaVE2v8Ak16Oat9Wgvwxjtq6takGFJeaTMohEvgM1KsWdH+RGLDDtPs2D8kdmTRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708126148; c=relaxed/simple;
	bh=XoZLsDGAjROcmQDGkI0Vj+qpzKjS9550xNB4tcENbIM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMqGzDG5FaTeI1nn7/Af/mIUOuw7w51mkghhFGuVMzF4wTT7a9imsNf5gLTQF+VWXKdsGnHPi6W+48EgQX2cMPqMweUX0SGLh2LFwUdUGAzYkn0RwfGZ1gxjbxXG1sdNSKJYAoiCrct5+PqnqgWQ5XF9MvXGv+koojdPZhSnAZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KdzknjbO; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KdzknjbO"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59d11e0b9e1so1278277eaf.1
        for <linux-hardening@vger.kernel.org>; Fri, 16 Feb 2024 15:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708126145; x=1708730945; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuVuB9WNnp6RhLhxcgBuf0qoep6pw4i+nNUSVjYdbec=;
        b=KdzknjbOeBWcPXDR9DRSwNedh4bnMhiww1IXTmC2AGa/MBHcq+Ffz66A8VOrzcmuTl
         74CaflRqwEDpv+MOsjBC8pJZTTy1nt44QmFgBk7OuduiFHQpLpV1tPrbHWnzQhXJopcR
         QBwSSBkKHbyS1ND4Xa6JSleactM17nX89qUzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708126145; x=1708730945;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuVuB9WNnp6RhLhxcgBuf0qoep6pw4i+nNUSVjYdbec=;
        b=sSzBt+wrSMTp+wJyLMn1AzzteRwwSzORTe3Pm3wVksE0xIB+B0/EO/Wyzi2FJybckK
         UYq7zdz9L7sfRkP2f68QJ125z6ot4oghQAFQgqH37jnxmilTvr04OqiK31yZlJD+XB2Y
         W5Zk5SoveXON57NKnXcu/0jHUx1xzXvgI3sMfqdKPx6hXiV5YuvXkF53z+cNaSSFEVHH
         9Br46GIoqQnGQFGuVNva+mbtQQy+jWb+fTF0F5L+HKxl0wlSGW3OPUrXPU6DY9MrYCyl
         qicYCQPL95TU94sPtQxU4qR9RjtRdGd5j/OJML6zaP2CB56OA1yZOyrJxgrDTScYb2de
         WkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcFoAcTWrl4qf1Mjb53vB+Cgg916Op7vhZnkuug6vZ6ad2GaHfHRZN4GgX7hjZNFlqywCC2YK5o8hA9KPyZgFXlIZR9Fei4mrAZVKmpeD4
X-Gm-Message-State: AOJu0YwA6Z2vBN2rgqorc1tjlU+svhE2MYcNU38zlNpJhNkI4H0ooIMa
	EqsxrLvLmGecFrCr6ia4es1P394omgt0aMDKDC96f0o7IKa9CmS6EgV3EIN76g==
X-Google-Smtp-Source: AGHT+IGkx/wYeGB3apgkwZolHTbHJV8+GpGlOZauTNmV+D51H1hWH34YB29ByFJkKMJCQpKS6k+1ng==
X-Received: by 2002:a05:6358:841c:b0:176:5a5e:4d85 with SMTP id b28-20020a056358841c00b001765a5e4d85mr7330542rwk.4.1708126145722;
        Fri, 16 Feb 2024 15:29:05 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d24-20020aa78158000000b006e053e98e1csm473041pfn.136.2024.02.16.15.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 15:29:05 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Anton Altaparmakov <anton@tuxera.com>
Cc: Kees Cook <keescook@chromium.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ntfs: Replace struct ntfs_name 0-sized array with flexible array
Date: Fri, 16 Feb 2024 15:29:03 -0800
Message-Id: <20240216232903.work.643-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=951; i=keescook@chromium.org;
 h=from:subject:message-id; bh=XoZLsDGAjROcmQDGkI0Vj+qpzKjS9550xNB4tcENbIM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlz++/M3Z7FKya3D8spCK/vdNEKLfnB2KXTxTqC
 SK8XCWyI3SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc/vvwAKCRCJcvTf3G3A
 JkVID/0VZ3h7rQqA3mm5DgQ6ZDY16VEAqoU7h4tLtJLNTiCbPXGl44TkjjFg4Y0w8FfTfiDJHRR
 UKLFCkHvfM/szUWwDwmTIZb9K6g+4RO2lYvrKn+Sn8+pmOh6x/9WXFyrivXGfil3GMfsXz0nZzi
 QrUx36umTDyUBYU6Wy/UA+TEFYjpexSssGUq1qysuoTXK0KGiSGIwlSh33uHy7kjQ9JfQCjBJa1
 9NOnFz1yvqHyqbyabOaW4ZFMeewmyTetaHnqcnoLdjVKpClzrgLnraxdBpALu+LKkhqTgCIp2UW
 CHlYTZnb/6OBF9vvvVahO5bS9L5SkxSY4bW7PN7RVcajpwvkd0SGbJDETzzyXqNfNNrpCT8LXCM
 3N8kPwfG/mDrcH4Kt6pbAEI5ZJ0OfEhzDxhQ8T8ci0MVRR3dGNHqPDbHot+MhCrN2gNv4IhRMZG
 peqEQ+SZgzkO0gyuECwzZg1RF8SKWX6C/O9FuTMcR1ABEEpjpuryLfgZ/bAvqJM5v1OMZ/YG7SL
 Bunodbfu6AGfumyUSn2/jENcXF+maPiY3k5r3bMQSeKPprtQSdpNeMMK+IUg/60jFbWG70QLlIo
 /8KYW4bkTNM62i/VgBRq8iAvlIpsHUaJDxClhZeLKnbZkQpox8xv4W/fX6wZxHg8JT48dY7oOEv
 iGoVWH8w hEHSQTg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

ntfs_name::name is used as a destination in memcpy(), so it cannot be a
0-sized array any more. Convert it to a flexible array and annotated
with __counted_by, which matches the allocations.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Anton Altaparmakov <anton@tuxera.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-ntfs-dev@lists.sourceforge.net
Cc: linux-hardening@vger.kernel.org
---
 fs/ntfs/dir.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs/dir.h b/fs/ntfs/dir.h
index 0e326753df40..cafcd339094c 100644
--- a/fs/ntfs/dir.h
+++ b/fs/ntfs/dir.h
@@ -22,7 +22,7 @@ typedef struct {
 	MFT_REF mref;
 	FILE_NAME_TYPE_FLAGS type;
 	u8 len;
-	ntfschar name[0];
+	ntfschar name[] __counted_by(len);
 } __attribute__ ((__packed__)) ntfs_name;
 
 /* The little endian Unicode string $I30 as a global constant. */
-- 
2.34.1

