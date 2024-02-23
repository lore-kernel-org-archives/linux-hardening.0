Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6714F976
	for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708727002; cv=none; b=g9TyZ9LeKlMOM69Y8e4pamkUC6rayHGXrSj34a6r5lGa//0JAQcGE0oJKyaJcYZpMe7gMXXi7AItmmJSPIX0m/VJmSVXnFd0Vn/NOiQcmtpTCQ9UbVaXh5EhetjuXEAf0Xo15JMccW0YVb9w37PG3amhyIy68cEawT03zSocBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708727002; c=relaxed/simple;
	bh=qVrvMCX2jC2us3+TSRgSogfLEhmQgrU+njN4QmpejXQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=os9AzHYIhi7BVAFRubI9hzVlb5F1liKY67G8Y8mFMyfmXuCiXlxGSF0mTA7dYRz//aP7NDfhry+viOjpPRIqeQpUYzkAWu4bV06aEoiDAjb6dwmGVm3VWbjveDSLLYdMpWx18a0dzz1BCtTJZhSqfNa+a78KyFUzjFlYfNaTxa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GHmJu9fW; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--justinstitt.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GHmJu9fW"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ceade361so2417826276.0
        for <linux-hardening@vger.kernel.org>; Fri, 23 Feb 2024 14:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708727000; x=1709331800; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3KIALakHG9/laRdQ6ZTfVym3IzZQnguR7YMhf99jnUU=;
        b=GHmJu9fW6yYN75wF9opdDhAvtGsOfwlSlfELN5bu3IfxUB/dDSaIoaFNiQ7Q+ucII3
         Wwsw+amPEXFpOQhN0S9qoi5J1v27VnKxylwjXiC+5vaGMOQeJvyqYP0QRggL+ZaTkN3T
         iNJyZnSeXWCF2aK0+1ArQq7mikBsDFjttQ9byjklxkJOBvIMsLgqFFIPR2TKyOlZmqNa
         7vggN1pgOXDOkUP4A/JuigjxlvIGHeChDtUS0WKxzygb7qJV5l0rYFvi805OJd3ekea9
         EuCRwflHOaBTYXTg+EeNI3WplH5MB/efyOgWEklfDkF4YyQoyTqpJW0R/vYCu0CeKETY
         t4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708727000; x=1709331800;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3KIALakHG9/laRdQ6ZTfVym3IzZQnguR7YMhf99jnUU=;
        b=t7pq9c/UkH/+hNyIl8oSboQaKlfjtHC0RhuyshLUK4TXf0d+nMLb60oJmYKBgqVAWU
         RFWEuzxiQOXoiYexpf6hhJzDEwbFFrgEP3vA7ayTKBPYkFkS9683UJZ/I98IJ92U5J5g
         4ynY4svNfueaRbjeOTLW9FiDN+4xBWQbqFbSCTbZmnsK52QR2xOscx/cgWTa+Le2qGn9
         mu/ChcSw6PoEyM7dULS+n4jodEcpR8xYHDakIueL22LRgRwGOG4IadWCiiAQfR/Q8Mkg
         7UlZSIS3Ol8zwpehUADbYQAONZwLgLwypO4BHt5z8ptRHRjqwzjVwwGI2eqZ7h8FJciQ
         kOIw==
X-Forwarded-Encrypted: i=1; AJvYcCW4XBuLxSSrmt/HdGpWXCCy/cVyV/og1cvRmcK6xy18TbTyQJpajeH16BWeVaLll6IcDMd45cBLp2ZB8CLHtZzRSLKpJMrzg596g0BKsInp
X-Gm-Message-State: AOJu0YzB4YiTR/thZ3D1w4Sh668cdCG8/AR7dDlh9JaXLgJAhI1r5DwE
	e0NS+RM/l5UT4qXweGpg7Z0bijcKVxSboJ0eJABEn/QK1w1iEM1VBJPYa3dM1Ftt8o+73Gmq1ot
	gyDt85pujDNzpOB5gWfegrQ==
X-Google-Smtp-Source: AGHT+IFiCSZGKP73wvuFbiCmdDx5B4BSaFY73ra13deBRDZLa6qKQlcdxJHYgF0K/fv1cQKo50nfq00D2RHP+mhjaA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a5b:5c7:0:b0:dcd:ad52:6932 with SMTP
 id w7-20020a5b05c7000000b00dcdad526932mr303246ybp.5.1708726999910; Fri, 23
 Feb 2024 14:23:19 -0800 (PST)
Date: Fri, 23 Feb 2024 22:23:10 +0000
In-Reply-To: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-0-9cd3882f0700@google.com>
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708726991; l=1839;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=qVrvMCX2jC2us3+TSRgSogfLEhmQgrU+njN4QmpejXQ=; b=RdBZJFdZfPANDb2cGzpckDqgwU2vUQFXA8EjZm8UBaspyC5QFEZs9UScBXbOTkPJK8mUTfNKR
 Sh1ThdVtOXLDvDZnW3QQvs+Fx3MSPhzFmtGmWimF8Ia3uZ8W7loMNBs
X-Mailer: b4 0.12.3
Message-ID: <20240223-strncpy-drivers-scsi-mpi3mr-mpi3mr_fw-c-v1-5-9cd3882f0700@google.com>
Subject: [PATCH 5/7] scsi: devinfo: replace strncpy and manual pad
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

Depending on the state of @compatible, we are going to do different
things with our @to buffer.

When @compatible is true we want a NUL-term'd and NUL-padded destination
buffer. Conversely, if @compatible is false we just want a space-padded
destination buffer (no NUL-term required).

As per:
/**
 * scsi_dev_info_list_add_keyed - add one dev_info list entry.
 * @compatible: if true, null terminate short strings.  Otherwise space pad.
...

Note that we can't easily use `strtomem_pad` here as the size of the @to
buffer is unknown to the compiler due to indirection layers.

Now, the intent of the code is more clear (I probably didn't even need
to add a comment -- that's how clear it is).

Signed-off-by: Justin Stitt <justinstitt@google.com>
---
 drivers/scsi/scsi_devinfo.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index 3fcaf10a9dfe..2d3dbce25629 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -293,14 +293,16 @@ static void scsi_strcpy_devinfo(char *name, char *to, size_t to_length,
 	size_t from_length;
 
 	from_length = strlen(from);
-	/* This zero-pads the destination */
-	strncpy(to, from, to_length);
-	if (from_length < to_length && !compatible) {
-		/*
-		 * space pad the string if it is short.
-		 */
-		memset(&to[from_length], ' ', to_length - from_length);
-	}
+
+	/*
+	 * null pad and null terminate if compatible
+	 * otherwise space pad
+	 */
+	if (compatible)
+		strscpy_pad(to, from, to_length);
+	else
+		memcpy_and_pad(to, to_length, from, from_length, ' ');
+
 	if (from_length > to_length)
 		 printk(KERN_WARNING "%s: %s string '%s' is too long\n",
 			__func__, name, from);

-- 
2.44.0.rc0.258.g7320e95886-goog

