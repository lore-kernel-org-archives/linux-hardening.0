Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0414DFE6
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727006; cv=none; b=W1LtzVkMUAkAfX2+I8RaM6iHwmJHy7D8FIp3isQRm7g2N3NFENxDPxb1+VGr/Wc573EQJVQ7EWJkZAGRiweYWuWcfrsayVOKvGakKQgwcfppWdpN3rNHVBcIIkbPwMbw0M4TuFl4aTeBBU2yawYbtok29ONzkX6giYkNvb+eECs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727006; c=relaxed/simple;
	bh=hOmGJZtlyDjZ1c+JZUoPsWCm3VDSV2Qxk9ojvhhQIl4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ekLa99eWSpjfWEPnBSS/PKknuOFh6zSb/0WnEOIWRFPiAsldpXs9NZnc7E7XHi2mY0KZgPUFRfhc0ZUQkcCKhyZrI3SKvOMmJbvwVWqQPaJ72r6JQDbqzcThCm3wjCj1OlsyKTSFxdAxnelevyIwaIrlc1cgb/hs5Tvk3758YbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oNUYL41P; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oNUYL41P"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-608cf009bcfso3969267b3.3
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 14:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708727002; x=1709331802; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B52RSzoPz0mGizyBlMM5klXSYnyjiEEzzlSO34AH8fk=;
        b=oNUYL41PMz/Q3IMd+NQzFxIaU8oPcYn4K9UNWRO9ksFioJo9tKHO3aPHrBu5wNwQ8m
         z+0tmPmOWmhZT2XfAb4UCogn0X1yDEFcWJ4FEHiSU3Ww4sRMK45GDzfm5A8ANISprR4a
         /y35W1qM0CJzNaB+hirJlFd+5haXCDa7Sv7fjB9fRXaDB6sR5d3923uKUR2wyaiOLag2
         jK1bLmNFbHU3Ey1hVDrkm1etHg6KckVA8Ntvx7DFn21lfbnDsk23gLWNRbrqKwd+ky84
         ooxHCDCMZIB53S40ZbvEem/xVUXPM3iYKc4zlpKZe9nEV796PELrkM6/7B1NngHOxqKv
         zTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727002; x=1709331802;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B52RSzoPz0mGizyBlMM5klXSYnyjiEEzzlSO34AH8fk=;
        b=mV1S3F1jmxeQM318XcrGU/cmGTiysr7XxCXhDARzGAYTuKo7L5aLgHLhXpKmPxsr+2
         UTpBwmytXfDWMlilhtAZZ40Ao92XwGRFqavo8BdnOy2mTe6JeaQd6m8s7kFSiqZxQUWS
         30TaNh6vkFKqKm1chTiL/40XmJmbSYVEKT0+cUaRwbytVJRgP69RM8JQXmdWhqFvo4BJ
         buhFnkIl66ImRXaFmvyX/Aq/Ro9zGtaIRSfvc7s4jCM+QXAxtrrCtHR7vSuqnMswdSCL
         /R0FFVcK/yX2jbcB02veUxQZz3KsfSR0Zj+aBezQJIEZd4yLL1fdf6SPZXMo3+i9fptY
         /JZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1aoH3yQfE3PnqeYRcg6ZRZRoO2xNrLgXi55bwxfMHDK67/xwXXT1C+b6U4RKF+Q7VOM8ZIdA0ObViTX5MR+KtSj4vU/GKNG9OfiQGwJAS
X-Gm-Message-State: AOJu0YwkAyMCCGywAWyyGlF9q27o7xFbw3Rm5ZNgM6PlTz5ZBjFRxCpi
	XfiajTcthUwKpc46dx2gSOdZjsF2eR0XQpHTFFCpJQclEvbUmUHqJ0ybPXUCrv6lP40O8UkTb67
	WIOu2L7nGf1PJgCdgvOotMw==
X-Google-Smtp-Source: AGHT+IH8BvjewAAU/Jv7dArLAwd9BdZ/e/MwR4qJmFCTcWyLALkhZS5WODn66865ajzGJ9hhEHLQDedglmJ9E05N2Q==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a0d:e693:0:b0:608:c8c3:ab83 with SMTP
 id p141-20020a0de693000000b00608c8c3ab83mr210681ywe.8.1708727002358; Fri, 23
 Feb 2024 14:23:22 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:12 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=1256;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=hOmGJZtlyDjZ1c+JZUoPsWCm3VDSV2Qxk9ojvhhQIl4=; b=gkPicOXTAwPTmCTO1o4Csa4Ea/XzR3aEtcvkwKHYxFZjEsPcbRiLTwWkzG1rxvSX7nu/XoDOW
 Pwzi8N+lJSUCB95JSlYT2loyUZhhlTUZgecBJ0ACufjQ2+0aW7CJ2qX
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-7-9cd3882f0700@google.com>
Subject: [PATCH 7/7] scsi: wd33c93: replace deprecated strncpy with strscpy
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
2.44.0.rc0.258.g7320e95886-goog

