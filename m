Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DED80638;
	Wed, 19 Jun 2024 09:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790065; cv=none; b=W5ibpGJTPM7fa2+3u45TNH9HOSX8+SpIHmYdzbsa//bc29UiLbootIcAdUSKg4uMQC+PJmCvsImvJtDvOIIUdI6zjB1CHwLROmYMIfUXDcn01WrCm4nWFK83fBxgm3Xo3hmjvrK3zQ+ue8iB2psj1HkSTyUQD4uklCuZIsgiDUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790065; c=relaxed/simple;
	bh=Qg6GuD9uT0FjYhDJqubImg2K17b3CJlSTTIQ09qnDB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dAUd06/Mc0sCtY1HSx8RPooRZvZZVyHuvrOha3ca0xp0gnIvhxA9jrfkdXWj/iRjLT3UGwEuHattkmaly4bVSXntIw6BV+VgfumdJiwH7D8cM0ikDkHg3oNQoSNetQERqJJO2PN5WL/dnoDI5awbpkT4lZN/CGbHFQyLEFuLCno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHmgL1Kj; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHmgL1Kj"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42121d27861so49751805e9.0;
        Wed, 19 Jun 2024 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718790061; x=1719394861; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r22BRKQXYcHOcbW5qU6bmdOJSTmqJ20MxR35f7aK9/A=;
        b=BHmgL1Kj5iclisI+DC+6STb6ZX5dGHyGnEYx1laRQJmQwIQ5BoEPLs5VoAAjI8mZuq
         VDJGlMGZ01DcVYbkB69rwZNfoCiQnvK1bnpDMGCMPDCbm0ScQBmhV5o9CK5EvnreD97s
         oeP/9oXZGgzG27HQxk3JfRJAjUNsoiHMlvpHOnkvYq0JCdsmUaPMuSjukLZGuwA3/uWB
         G7A+74nL7RRCP9q5d/daZrgOM8ZlHDh3tl0EHQ+SNWxNsCEc4PyW/ML+WS5Cxe52r0Om
         8O54mAuEIYpYizeMCSc+OPX+rntd3V37gEYMVA3PGF559SXi0t0ogW1m+nA3WxhAtAVz
         1sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718790061; x=1719394861;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r22BRKQXYcHOcbW5qU6bmdOJSTmqJ20MxR35f7aK9/A=;
        b=hPC3k8AQRoTDO78APt8mz8f4qUV5Myavbp1pEXlu75rUnzXQ1tNbdnBA1r/ZLAjBS9
         SbL9bmJYrp/rhfUJuRiXNVl0SOJ84DcogtGv/M/f2WUFul82AH55L4fEL+cixqcumdbs
         4I0OwBrs77LTXWtKyGKT3lMY/dpR+FKuZl71kkLwyh5iUfkLJ+ArSeh201arvP/AN7VW
         xwhBMpxINcrpBlTs9a3b/sEIVWU2hMU9YOI7yTd4NrbS1HZAemn+GjWSgMGIIYkMfKJK
         hnuQHbn0jKsPhgEU2w0WrfhMLwMarOXe8xqlyzIRwnz0PLRDugFgL8Me0K1Z9o6ZSvbV
         hY9A==
X-Forwarded-Encrypted: i=1; AJvYcCX014WX20ugXSObpdIrPI6pPWVyUJYavryE7ieD+CXXrEBA+V4nPGipj7y+iHnByMNFg9lChWXcG3vm+JX9c6n0kJZXHUTxx+j2M0i7vrCi2oUk5Mbij1C1oAEaSPfnB/XkZJd4YkAttIuEZOSN
X-Gm-Message-State: AOJu0YyInlfdIxxhaCqjMVBZqyxr2RWDBP6PkQngQCE0KeAUEVlDxs+2
	GmYTn2Dpzc1EI8HGqyVP0Iv5Whua9cVQvtOLO29o2cw/WMJAg3py
X-Google-Smtp-Source: AGHT+IElF7dg8O3LJe50WO5VqjUMPh2cpDUpsDriBW2iVQl47dtiuAO0Ws2JcFXsP6UpV3klb5M5gg==
X-Received: by 2002:a05:600c:35c3:b0:421:7bed:5274 with SMTP id 5b1f17b1804b1-42475173ce3mr16488635e9.10.1718790061178;
        Wed, 19 Jun 2024 02:41:01 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-103.cable.dynamic.surfer.at. [84.115.213.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42306049f1asm182804075e9.22.2024.06.19.02.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 02:41:00 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 19 Jun 2024 11:40:57 +0200
Subject: [PATCH] USB: serial: garmin_gps: annotate struct garmin_packet
 with __counted_by
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-garmin_gps_counted_by-v1-1-d8d816f085d9@gmail.com>
X-B4-Tracking: v=1; b=H4sIAKincmYC/x3MQQ5AMBBA0avIrDUp1QpXEWnQUbNQ0iJEeneN5
 Vv8/0JATxigzV7weFGgzSUUeQbTMjiLjEwylLysuCoaZge/ktN2D3raTneg0ePDRK1kJRvFhRS
 Q2t3jTPf/7foYP5WT9QVnAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718790059; l=1151;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Qg6GuD9uT0FjYhDJqubImg2K17b3CJlSTTIQ09qnDB8=;
 b=AebiJqrhEZoqxVdOt6AGpsJ3S/JQfLwNfhVOY++mgZwM+D/d/7g+jZIVsIR6q94qhuAkGG7eX
 ict+JBHmecYBkDJ9r7+wq3TtL94ZE7beQOexXCgFNweWVRff/v7UqZC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Use the __counted_by compiler attribute for the data[] flexible array member
to improve the results of array bound sanitizers.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
The size is assigned before the first reference to the flexible array
(see pkt_add()), which allows for a straightforward annotation without
further modifications.
---
 drivers/usb/serial/garmin_gps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index 670e942fdaaa..57df6ad183ff 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -104,7 +104,7 @@ struct garmin_packet {
 	int               seq;
 	/* the real size of the data array, always > 0 */
 	int               size;
-	__u8              data[];
+	__u8              data[] __counted_by(size);
 };
 
 /* structure used to keep the current state of the driver */

---
base-commit: 0c52056d9f77508cb6d4d68d3fc91c6c08ec71af
change-id: 20240619-garmin_gps_counted_by-376545960353

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

