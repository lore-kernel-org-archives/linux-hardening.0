Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6422B158DD9;
	Wed, 19 Jun 2024 19:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718826185; cv=none; b=uPn+o7tFxRZxr8JhL71G6BxLhd8/9aRd8g3U9ikZ9DI7PSh008hwuS1kbNcbCAJulVJMAEdN4PyQvi4ghK13mUfetbvxhROC4EzlWRuaN3BQq6QOI1h5VYXOeW4BsfMfftS6w1peE3XYlHylUcUIcw4rZzKEkauADiOVKmZ6cgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718826185; c=relaxed/simple;
	bh=qCJk9bWEc+/fuCHJqn77Np+/NCaJz6B237shZlGk7wA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dlPppG5jvnLPLLa/pDk5OT71eBRFa49H+roN1KDGQFgYXAJLkfJoHSCDb7fKAjEw3PjDKrdTTIke6XGAm7NezQJV2escJRWkth3rv4tIWfxnwJ7GfWkU4j7wGEb9NQoZDDCvyTu29FwYhYQ0trpwQ28lvDIaoTI1Sqr31c0C0yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8MvQ1lB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8MvQ1lB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so11749166b.2;
        Wed, 19 Jun 2024 12:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718826182; x=1719430982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n9z63p6lskMirNgu/7X6osNx5PNpqMrbPB+Wm9ztJrU=;
        b=W8MvQ1lBWfT/IjO68EMrphvJqOjgvG621IQxIsh3Gs2ZqjlNiqVz7HL0YNgqRuhI62
         xyamyR5RXBw7KE/LSrahlYd4AImhhAvFu1hgLWx86cwKy2qpj9xtyb4kjSbDUB3o+2bP
         M8qcV0w1bHpCycf4v8AoIgw2T3yN6Ou1ukfBC496mVOmRXjte1G7u2KjPGDQwpIbh1U/
         yLCwXXutKjTixUmCp2DVx1BcTmLfOA5Z7S1XeLbvER+ZjiPNACpktB82R31Sp/0Ulmo4
         BvvgURBNsfrtDAO3Xpjnbgu6qcwr83dDPsuNrCyopX+q9wtFY43opmAnUHR3mkT/DtpC
         HHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718826182; x=1719430982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9z63p6lskMirNgu/7X6osNx5PNpqMrbPB+Wm9ztJrU=;
        b=UCZEweRik2r4ajjfY+m2M6jLPkrom1csmW26bbAcZu8pp9lJ2W0YL7AZLjhsM7MX06
         Qi1Q0SF3/99GRburOjjnxOFN1tZv0mmEJ0FhVMWI2HlP/8FXIPa9PGzRtJEAtzD6ova/
         SIGOKtilkaXrf28UTJJSMOy2ByuYorOWjYHneIKh6lJ7e0+VGprWJqCdqNfXroA2Icqt
         smjm1vfY4Z7My1M9FD73RiQ2Y4gcmreacrGwCsAIDkQ2FuSXRSc5oCa61p5gGVlCrAA6
         lELAZcs855PvIaN0wdIwy8y4rzIKkP5nCt2vWQbbMoWxbhP7MIhk3t3HPo49/0Kp2Owy
         ajng==
X-Forwarded-Encrypted: i=1; AJvYcCUwyyrQA+WdQ4pn1zlP580D8coUgiuyEPlngjtoIXFZsADmgZPqsZRd+wXX6q8Gw2qsnA1I/V/xHqSF1ML2BQ+XKKnBpKoKRrnieyHIMf3dHAnrfHiSta09/Hna8uGyypw+L9YsM7Q/1SqxjRFA
X-Gm-Message-State: AOJu0YwxlZUP1nNLnYxOV6fiCplaRYP1RjhqwYft65wPgnVk/y7HWrch
	+q2OWf0qpJxEOkK6raCIMYXyCzwWeY6np58Qr3Qzc7NdPSbidivryMM1jPcW
X-Google-Smtp-Source: AGHT+IGhnnBv0QoNxw0IXvKXUeKA7OoxHA1cnv3LEAsfVt/4l2CCSjKit1x7O4p8BBi5/H5VF3Bmzg==
X-Received: by 2002:a17:907:a095:b0:a6f:b34c:76eb with SMTP id a640c23a62f3a-a6fb34c7838mr180373066b.54.1718826181747;
        Wed, 19 Jun 2024 12:43:01 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56da3385sm688365766b.24.2024.06.19.12.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 12:43:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 19 Jun 2024 21:42:45 +0200
Subject: [PATCH v2 2/2] USB: serial: garmin_gps: use struct_size to
 allocate pkt
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-garmin_gps_counted_by-v2-2-f82f10ebbf28@gmail.com>
References: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>
In-Reply-To: <20240619-garmin_gps_counted_by-v2-0-f82f10ebbf28@gmail.com>
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718826176; l=869;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=qCJk9bWEc+/fuCHJqn77Np+/NCaJz6B237shZlGk7wA=;
 b=cexK0HonegmOr1iAcrxTSFtX32J5Razx8ZpgrRL6ih52oWsn3hR9bgc/J3g0tkdX6cLrnZG8q
 eEZ8mKg7vbcBWjSIG2VzRHf37QEneJDUhAV9LGoM2IcgC4OZhrLYD1o
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the struct_size macro to calculate the size of the pkt, which
includes a trailing flexible array.

Suggested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/usb/serial/garmin_gps.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 57df6ad183ff..6d6ec7eed87c 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -267,8 +267,7 @@ static int pkt_add(struct garmin_data *garmin_data_p,
 
 	/* process only packets containing data ... */
 	if (data_length) {
-		pkt = kmalloc(sizeof(struct garmin_packet)+data_length,
-								GFP_ATOMIC);
+		pkt = kmalloc(struct_size(pkt, data, data_length), GFP_ATOMIC);
 		if (!pkt)
 			return 0;
 

-- 
2.40.1

