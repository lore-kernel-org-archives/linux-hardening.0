Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818216;
	b=ixPY94WwsiOB0+mB7T0d+kF+TlTPLHFkwRSC05NHdSvKS3rhblkEIdb99Krq7eiHTF3g
	 I18RZwdwyUF0YdN4rwuEcJXsViTUD67QWWXKQxIuDTLxPLzL8o1StRVEBD30qcsvq1h4j
	 knqnXdFfmYzmSEGCU6OWG+yrlVHMrj200Xm+fAuAwINFfgHqo2h+9julrqUNaAnGkiPrz
	 DINiSxrpXuhN2wJPmxBJp50FSYQDlT34ddkOgXsqQV3vmprs7S4R0RrmXA1Gu2OQhRHKa
	 +r21/dMoY7bEa8HZCIHBTCcGgC+GZNiWqHfuuG678Trqoe8Pkn/AlCbxVd95qcOjy7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818216;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hgpz0Pnzy6Bfb4EoHwUzOVn72wSYeBzOC2xJFHZCiaw=;
	b=KRGTRuaLTz0ooiwk8nPRG75+tbZehGSbxEnuDClXCVtjLIjc4N37Eia+gIcctaHVDj/o
	 fA1Lbz8qt0r3owANCIIM7X3fFYQ1eRikyoWp4dp7Y4RUgnyCKqYhTSkkIuGilNHmGD8xd
	 1e8ciCjcQx7BQrZn8uu+K7fCdVbOYXa/Z1PPmuPZmHtBN34s/P6aFbSmvFvK1fUdMKUPM
	 gSlf4ndAFV1hnXIj2GQAw9YGUMmQoFv8GW4xYtCv70MJSd21IhxXJ0iuTgy2LPSQia032
	 JE5Ii6YBkrgz0evsbPdUb5NR8PAx/Jt8VmD7Ya01oiQYT+LME7PQzxVPwl/H63zOeBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YotFc647;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D6606EEAA
	for <linux-hardening@vger.kernel.org>; Wed,  4 Nov 2026 18:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E8D6606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YotFc647
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514b90bb89so1964751eec.1
        for <linux-hardening@vger.kernel.org>; Wed, 04 Nov 2026 10:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793818215; x=1794423015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgpz0Pnzy6Bfb4EoHwUzOVn72wSYeBzOC2xJFHZCiaw=;
        b=YotFc647PWWOSnqtkGAJO+BwusgiJSDM0B4ngFBzpTRO1s6hMLg9u56bImThbZw3BJ
         w78BuBiIuPBCzbkhE7v1jBaf/RmNb06NvLwvmekA4lM3nrBmq4YhgzM0StGIUMiOpY8v
         sxvph2MFnawEm1jX28LOZpzneWAUeuYrk97Hgz8o9EGBi2bo+NeyDbLBsQpcGpJj0On2
         1jKLCZJa9nj/LpemUhv2OdrsmhGuplVd0L2wVYQTf9+fUem+YjVSLFvrPs7LE4pNpkiH
         4q/Mc3NXV0ndQJXxVo5dHePVqPaNy+DVRytdUtyY1e2k+vENVM3gyGv7j4wclkahHwYS
         fIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793818215; x=1794423015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgpz0Pnzy6Bfb4EoHwUzOVn72wSYeBzOC2xJFHZCiaw=;
        b=aDuW9cVLJQAhRChHbu9Tu7hxpBue1WJtJkId9zRi+678SrNTpxwPV7gQrY0WrDNLGp
         9fHvE2e9FtGkavAZ+Ue0h5NCGcFJt1G+XtLz2ntX+xzlSz9rN+de2o7GSSXdb4hWoCdq
         KHH9EcLaUV2/B9WSS2YK5zCKGQzu8ZfqdcVzaW2lRdeYaNR1oNN1ECOWtm/yga2JFiyr
         hmY1xEDLbRZdedvE8S4lo4aKZPJ6aWu9j/JFItZzs5UGMnNxtd8nNvrQf4kzbS5JHNc9
         OsMlaqGpZu88dq+nIoLujGzuYkTiInt87ygeBYnXPSolBxshlLz06G0R7fI3xGS0GTJi
         0s7Q==
X-Forwarded-Encrypted: i=1; AKwUvBzUlMt0xYMfinO8UiO9OWCX6fGiy7IzegOira0YfJ3oX0csjPw6K7azp4klRDzVurbKWIMlOaGZQNcgD6noJJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z80WiHSavRa89t9K2rKD1YSSnEZNAfVr7GXoskHHgTLnsUsPXJe
	uuP8LF7fjLpQr9KSBRzTn5n9j2tsaJbbaVK3t4I8IzsUnMF5WOLLIteP
X-Gm-Gg: AYBFou2YTV3FJdZOrb+QMbMmI2fUohmPzIiDb0JkQnB7TUfNecS5BBQkxqNX4F75dGI
	ED7PTwjM4a/RF48PH2Ji/YZ98kM5UFwC0UMr6GTaKu7FdgOPYTiTFoLHTY6gHOC9gk6sWSbiOc1
	aBwR6KBlBk7IoSzNFscSHSckNBJ5FRyGkYxejghp9bMp0c7GjeWxD9oR8mPAskqk+SPoTuDb4Bu
	PBy5oR4xY+PtoLr2MZkk4kcz1FF6RtC1jByX1NjJ/6GVlf7tsn8kEBTEk9WmxE2E66Ty36CKfgY
	d0QUiGTqP9PlP/XQjCLXbsR2cfPh0+Onct23xTGs9ZKygBUfiGjF2jkehH66NH4Nmo5QQKduhtl
	rIH90Ni33mnfA4xzs/QOIF5uEBgsYTi/EAz7+c0HG0Q332K0KW+UoCiogEO3xPcH1cKG35YvJdb
	rQoVvLTC+Iu6ssIjureNFTMZ1F8EzpjZxXCfB4sBGja3JH29qu17zVoXKvlcYcZrVNQGdeHvPPv
	HMzux7p/lvNVXNjVYwtC+hSddT2e7zQFcGBnLiJTcq7O1q8OsMqsrvzE/rxowJL9n3hy0UKpRjC
	ziScV+4D4lL8MKSBDmgX3gRvs+4B2ql2JbJ22JgJ44jY+Eo7MSZyNWtQ7TM=
X-Received: by 2002:a05:7022:29b:b0:151:94a6:6f5f with SMTP id a92af1059eb24-1ac5c3699aamr23820953c88.10.1793818215406;
        Wed, 04 Nov 2026 10:50:15 -0800 (PST)
Received: from homik.search.charter.net ([2603:8002:ad40:56f0:81ac:fee7:f533:3879])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c772fdsm11330186c88.22.2026.11.04.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:50:14 -0800 (PST)
From: Mariia Nikitash <nikitash.mariiaw@gmail.com>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org,
	justinstitt@google.com,
	morbo@google.com,
	alx@kernel.org,
	shlomojune6@gmail.com,
	Mariia Nikitash <nikitash.mariiaw@gmail.com>
Subject: [PATCH v2] media: siano: Replace strlcat() with snprintf() in sms_ir_init()
Date: Wed,  4 Nov 2026 10:50:08 -0800
Message-ID: <20261104185009.319191-1-nikitash.mariiaw@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
References: <20261104090239.311074-1-nikitash.mariiaw@gmail.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for removing the deprecated strlcat() API[1],
replace the strscpy() and strlcat() calls with a single snprintf()
call to construct the IR device path.

The return values are unused. This preserves the resulting
string, including truncation behavior.

Link: https://github.com/KSPP/linux/issues/370 [1]
Signed-off-by: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Reviewed-by: Alejandro Colomar <alx@kernel.org>
Reviewed-by: Shihuang Liu <shlomojune6@gmail.com>
---

Changes in v2:
- No code changes.
- Remove the statement about buffer capacities
  from the commit message.
- Add Reviewed-by tags from Alejandro Colomar and Shihuang Liu.

 drivers/media/common/siano/smsir.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/common/siano/smsir.c b/drivers/media/common/siano/smsir.c
index 283770d583d5..636ff228108b 100644
--- a/drivers/media/common/siano/smsir.c
+++ b/drivers/media/common/siano/smsir.c
@@ -55,8 +55,8 @@ int sms_ir_init(struct smscore_device_t *coredev)
 	snprintf(coredev->ir.name, sizeof(coredev->ir.name),
 		 "SMS IR (%s)", sms_get_board(board_id)->name);
 
-	strscpy(coredev->ir.phys, coredev->devpath, sizeof(coredev->ir.phys));
-	strlcat(coredev->ir.phys, "/ir0", sizeof(coredev->ir.phys));
+	snprintf(coredev->ir.phys, sizeof(coredev->ir.phys),
+		 "%s/ir0", coredev->devpath);
 
 	dev->device_name = coredev->ir.name;
 	dev->input_phys = coredev->ir.phys;
-- 
2.43.0
