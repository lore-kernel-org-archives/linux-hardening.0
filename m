Received: from mail-io1-f74.google.com (mail-io1-f74.google.com [209.85.166.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E588A14CAD1
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727003; cv=none; b=dFOoN9klw251i4eakTjogfddizwApPaag7HKCTmFEvgC+iGAfEXESjVp7QrZKTbiYpyeqJ/GIqbRo1vRRAPEvJ+9rYxvUQQ9H4Ze/oME0fMpyxHA1LAaLGAxXXAlwRXHOez2XrCCeep6SxdECOOsMBZaCENZbOWWOSoU5MRSq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727003; c=relaxed/simple;
	bh=HNaL6iq4VjkVLk6rkA3oheMksvR27M2MbWdhUwoMJJA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CNGR6EHf7hyaq7lZKBcIXI4ZDVsZPaLViszZKoopbzv1eKuVldLB9RWZjNjb1WCGv2SAIcYaKu4V8lJZQtP9ipcSeaFcb+LUzv4XdRIawqWcCpDpJaTG25Y7RARG8PSyX5wCFIFl9E9HiTzoxWp8oFRn+sT531Zo6RkOnTZWfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nkkicogp; arc=none smtp.client-ip=209.85.166.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nkkicogp"
Received: by mail-io1-f74.google.com with SMTP id ca18e2360f4ac-7c0088dc494so96115439f.1
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 14:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708727001; x=1709331801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5D+c92Mlv0UvdtC+hh+RCrhaZKYccDyKUaajpaxYKs=;
        b=NkkicogpEccegso3Buaf9aDhYD5FiDLNM0fTeQv7FIndXXUyJg5PTnEHdF8U8p9aH2
         bvEI8mAk3Djw2nyDeOB0iVwWonCQDcd7Q/UEKpuSk1NrHkiMxrZ5+nyEMo9UjS30JUFf
         UAB40j/GXmpIUIJxldzxpFh0+AgBBk2t0FlR79+21G/s4Ij1ohCidl4A2paOYwcRvrTe
         5qlGshmr4nhI/kfoIzZWQONb8ZpEXUbuP5K+iqXswUXAR9AnyoYQJPvUqkXq8MiOZA40
         iOjy36c/H2GKgiThoW0ypq0DWaEsI32vyLKYVnvGdzzxj1Sj3MCxe4Qxb1Vb/FMn6yHT
         qHGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727001; x=1709331801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5D+c92Mlv0UvdtC+hh+RCrhaZKYccDyKUaajpaxYKs=;
        b=VMwzegcRKf/yzIca+lptoXniORIpESAAD++HmHwk8vJc1FBlE2OzQhxeZHrUGMW4qN
         fToviC1yr5PPxFOUS4xj5YRaCi9mVzxJtrCr+NW8aIRs8McdPVaLkapa5KXck5hlH8MP
         fxibHoE9X0Hr9SI4wNVimWXIMmXtyASH2IBiM6BExUd0YdwQWNMj48otuChtfNXGjKs2
         HIDKpWFbeDOA4caDwich2RzSWrzbzV+iZ9//tsD5YsEupUgsUxv8d5zSSjN9hb8o4CJ5
         EzG3NrdrYVnsJkSKjKYhIOxvWQQqX6PxU3sBLeWitKr9PqLoKxknaEbfTFU6hChFBGy7
         sGwg==
X-Forwarded-Encrypted: i=1; AJvYcCVBifiGt3Y9s2NwkasMSwDTNuyT3fAcHgPBzZIL5WY5fQ45N7pwJwsWmEehgxACIqMX0FJXUjavSdz7bfT+ulnDITVlrwyOJ87Pn9ZUuMxa
X-Gm-Message-State: AOJu0YyS0IRK7wVQSkkWK/btcvt0/qTNnl1KowKej2jmtpq94oxunWAq
	x6vun7Lq1d7DmCTrINiQXPXEvPBmwQTFHMaS8QAHEj7pbEYKTgGO2d8Ijr2a8kHQdvoiEarzqGp
	ONSgQKt0XAazQVMRkRoqiEw==
X-Google-Smtp-Source: AGHT+IHlC+dEi/zD10YR+JQiEfRzKOFmYm1eFgQEa7+UytzoWGtQLgP0oSLzRukFOiaIdXLRIuTVxtC161n7/u6g2A==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a6b:5c18:0:b0:7c7:9b21:b78d with SMTP
 id z24-20020a6b5c18000000b007c79b21b78dmr6731ioh.1.1708727001074; Fri, 23 Feb
 2024 14:23:21 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:11 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=1441;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=HNaL6iq4VjkVLk6rkA3oheMksvR27M2MbWdhUwoMJJA=; b=9zWY/IUx/7d7V1x/CpAqf+oZK19wyKGvGOEiF+Whpiw7893M8CMjPdX8S/PzLmqvBhoCiE8n7
 KhmuaY13/HPCCjsJi7NWc5Bvc2vAQ3nBpOwLampB+fptg7qnJR/eqRM
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-6-9cd3882f0700@google.com>
Subject: [PATCH 6/7] scsi: smartpqi: replace deprecated strncpy with strscpy
From: Justin Stitt <justinstitt@google.com>
To: Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>, Kashyap Desai <kashyap.desai@broadcom.com>, 
	Sumit Saxena <sumit.saxena@broadcom.com>, Sreekanth Reddy <sreekanth.reddy@broadcom.com>, 
	"James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>, Ariel Elior <aelior@marvell.com>, 
	Manish Chopra <manishc@marvell.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Saurav Kashyap <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>, 
	GR-QLogic-Storage-Upstream@marvell.com, Nilesh Javali <njavali@marvell.com>, 
	Manish Rangankar <mrangankar@marvell.com>, Don Brace <don.brace@microchip.com>
Cc: mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, MPT-FusionLinux.pdl@broadcom.com, 
	netdev@vger.kernel.org, storagedev@microchip.com, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"

buffer->driver_version is sized 32:
|	struct bmic_host_wellness_driver_version {
|	...
|		char	driver_version[32];
... the source string "Linux " + DRIVER_VERISON is sized at 16. There's
really no bug in the existing code since the buffers are sized
appropriately with great care taken to manually NUL-terminate the
destination buffer. Nonetheless, let's make the swap over to strscpy()
for robustness' (and readability's) sake.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index ceff1ec13f9e..bfe6f42e8e96 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -1041,9 +1041,8 @@ static int pqi_write_driver_version_to_host_wellness(
 	buffer->driver_version_tag[1] = 'V';
 	put_unaligned_le16(sizeof(buffer->driver_version),
 		&buffer->driver_version_length);
-	strncpy(buffer->driver_version, "Linux " DRIVER_VERSION,
-		sizeof(buffer->driver_version) - 1);
-	buffer->driver_version[sizeof(buffer->driver_version) - 1] = '\0';
+	strscpy(buffer->driver_version, "Linux " DRIVER_VERSION,
+		sizeof(buffer->driver_version));
 	buffer->dont_write_tag[0] = 'D';
 	buffer->dont_write_tag[1] = 'W';
 	buffer->end_tag[0] = 'Z';

-- 
2.44.0.rc0.258.g7320e95886-goog

