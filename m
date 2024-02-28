Received: from mail-il1-f202.google.com (mail-il1-f202.google.com [209.85.166.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36F57D083
	for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709161160; cv=none; b=fX1cxrVY9F/g95GP7Q9Ljb4aSSMgki7hi5ucqABCaZ0d8eiskKpBI2AvDN+ZGiKGAVHXC8OPGhGaHCo1exwboWTwIaEc4IdypuUIgdyU8sqv32dX977jecoL3/PpXtdxSrR4QHAvZrNUOGwqYFEqAtc3edR0EGkpGqLBUup7f6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709161160; c=relaxed/simple;
	bh=lLsSWUlgp7HueQKOzwtJI79py/7OoTHxtK4sEEcMNNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CrTPPePpQnYZxd3eZfL9sc20gCB39iI6oA9ogVR+KUgX9q2ivbmuXTEhqdAMFneR+BbrRL0ibF/R+PJqpI2fwHSJ0Ja1DJSjTmfqMZ9nZWLS98J4MKZWD8Y3kvorUfRtsWS+dug0vcJ+5zTN8jAqQENoK8R3CVXuQVbNecUXNqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Do6crlRz; arc=none smtp.client-ip=209.85.166.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Do6crlRz"
Received: by mail-il1-f202.google.com with SMTP id e9e14a558f8ab-3657bb7b9d2so4966675ab.2
        for <linux-hardening@vger.kernel.org>; Wed, 28 Feb 2024 14:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709161158; x=1709765958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HhfHnaxbWsSYThMRH7N1siBwLrWUAgtSctM6HfRV2Ag=;
        b=Do6crlRzhDsizeNjHwbDPNw+B4lVIEE0TsBpogvqy/DEpNJkzRPpOnRxXtLHYjgsV1
         zn1egIRppZAfZpOMPonIF1AwJWsckjNngRcegPehVpjM6A5OVSYE15UNuOTDIDuGDt9m
         3I5KeQ5cYvz3KNMGfvfcUxnpymB1B7RRpc6sLB5ypFWONCH/nh5ig9p2c6oXmdk0ksJq
         sXMaQH3c1vAfCJdlA/+LAJJC/Tc49nv+920AU8TmSHEdY9/GUbrEzK7OHr3SYLvu37fK
         ws0QMRN0iO8dZRoQ23zjteUqdaIHS6l/I8OXAi+qA50MU413sXJj9I8v5zP/VQWM5H/V
         eFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709161158; x=1709765958;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HhfHnaxbWsSYThMRH7N1siBwLrWUAgtSctM6HfRV2Ag=;
        b=bezkbIz8q695WQBxQF4dIlbmlIS36rPJOaHGbUoHofjzvxdwJrb9wOfdeL/MUzoxui
         c+uYEsPFXnhRzKiv3cFCxngKMNm59gydjqmm9n7x0GzDujo8FdD830Fmho5mVMTy9CGv
         Tp0KV/Ir2Q+/nl4ABtWm9OXhjDsrv1Gmsd07Fr6TtZXBtEu5J2lVz81IpANb/2vtvFXN
         mouYKtiOMxc2VmtBAMKBQrK+VivorK7RLGLhytNoUUma1A0D5V5AXN9scyMIfrkA6pGj
         PorpMP7NCthY3k5q3M4SB9Cadcpm7B9FCFachBY/l7kRFTzTQXXnHy1Bz71yQ2k3Z0ib
         OJkw==
X-Forwarded-Encrypted: i=1; AJvYcCVur9Lyzxm7IZart/8AyHZclpAU4IV6hNrcPNxiqw82UvZ8F4ak0njcASAMMYZPe5cyDYhBKmK8gZSW7WKMaop/6qx5pok6qHY9ID9msaaW
X-Gm-Message-State: AOJu0Yyr3BqzoOCVMvtm3ecQpHXNtVtL9g+4Y+t75iJVdULZuU9fl01E
	fzmvilS3bgsPls04aD5LBPfQfXBtPPUdTghAuxuWJbhzbc/m0BQfVYT5ZR4U8CjdeVqlvaQj/pl
	b4Ogyfxj64OodJrajwbTflg==
X-Google-Smtp-Source: AGHT+IEIrIDo5sTt6gMSCiyyslq0yK1A1xLzdyJOiaImV0GkhHuEn6/P8wZRb8UKtb0X7RlT7oI9X/gwcnVP4zsqSQ==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6e02:1c42:b0:365:1f2b:7be8 with
 SMTP id d2-20020a056e021c4200b003651f2b7be8mr40548ilg.5.1709161157889; Wed,
 28 Feb 2024 14:59:17 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:07 +0000
In-Reply-To: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-0-dacebd3fcfa0@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709161149; l=1256;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=lLsSWUlgp7HueQKOzwtJI79py/7OoTHxtK4sEEcMNNg=; b=O/Y8/j91ffHOW/H1lkp7P7xEh0IoohQDvBGDW0wX5DBkBQO3wENCK+STBh6SvA2jO4s+2rUiC
 /3kFM5uAc+ABhNpGPSm9eO2vRTlpeqKmRKJ1d1onyaPQI7F48pNtHxB
X-Mailer: b4 0.12.3
Message-ID: <20240228-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v2-7-dacebd3fcfa0@google.com>
Subject: [PATCH v2 7/7] scsi: wd33c93: replace deprecated strncpy with strscpy
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

@p1 is assigned to @setup_buffer and then we manually assign a NUL-byte
at the first index. This renders the following strlen() call useless.
Moreover, we don't need to reassign p1 to setup_buffer for any reason --
neither do we need to manually set a NUL-byte at the end. strscpy()
resolves all this code making it easier to read.

Even considering the path where @str is falsey, the manual NUL-byte
assignment is useless as setup_buffer is declared with static storage
duration in the top-level scope which should NUL-initialize the whole
buffer.

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/wd33c93.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/scsi/wd33c93.c b/drivers/scsi/wd33c93.c
index e4fafc77bd20..a44b60c9004a 100644
--- a/drivers/scsi/wd33c93.c
+++ b/drivers/scsi/wd33c93.c
@@ -1721,9 +1721,7 @@ wd33c93_setup(char *str)
 	p1 = setup_buffer;
 	*p1 = '\0';
 	if (str)
-		strncpy(p1, str, SETUP_BUFFER_SIZE - strlen(setup_buffer));
-	setup_buffer[SETUP_BUFFER_SIZE - 1] = '\0';
-	p1 = setup_buffer;
+		strscpy(p1, str, SETUP_BUFFER_SIZE);
 	i = 0;
 	while (*p1 && (i < MAX_SETUP_ARGS)) {
 		p2 = strchr(p1, ',');

-- 
2.44.0.rc1.240.g4c46232300-goog

