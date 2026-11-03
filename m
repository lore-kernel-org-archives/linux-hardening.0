Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714372;
	b=5tasjsh7wnc9TdUIPPbTMoFJZRIuqUmYb0cOw5UoGoQJrkI29sNATKkjEw8U4UWVNEis
	 oVb+p3g9jI4qgMVmB9sRJhkrcBksVQuzCeIKxf/d43dep4SFBBGl8uX0m9WF2oDbYD+jU
	 gibhdXB4XmqWQwTWfraEX0GiUoyVoxOugcco68daWjnX0cO8gCyZQ31X6d29lqNQ+dFXH
	 QGc+YFz/B+YhxMfdR2GkV/s5MQyr3QgLweS48VcfyWxYuVJDMwfeHqE83ltiAgd17e7Zd
	 efl0J/kKKk6fjqd7T8ADNw5mmbF000ude5b98EFrwrICQUegDiUt6G7/aX+8e+Hl+cA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714372;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=Qngkg57Ni1YhWMlAtKTzwfofY3KWH3EsG38ilqqk6Gk=;
	b=GGiK54re+ehigOqAhnLbdvi9ZNby+z9MTA+UKRo1pHQXpbCOk1AJU3FBtLx1coDK1Z9E
	 5iwKyJFqp2mWNQXu01d7uLkH8eFVI7LJ+n7tyEZKh+d5atuXMuB9P+aQxcVXUn2unWyAL
	 DLNJbyRop+rbJgoZ6usGOAmPE0L6X8z8h3e/l3670tA+R0D1qkO1hvkCGCeMX/5RGCAvj
	 KpS+2Vf0NrwX4GaD9TLd4A/yJNHJNVhCp0gxCxob6ZLAEvTE1J3uRntv+dSauabhMCpo7
	 In4IvnQjBQPNg0xFx5z6SIKKK1BZaPw2i2j6TO3uOjY7Vr+bVPfF6zeroMkx359gA5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RAZNGhku;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E393606EE98
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E393606EE98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=RAZNGhku
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ad787b79ffso2564887a91.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714372; x=1794319172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qngkg57Ni1YhWMlAtKTzwfofY3KWH3EsG38ilqqk6Gk=;
        b=h3u1DhErPyRK6uvarXu6IILtCxzEmSCZz3t/r/FStTmw4MyXTSbijnUANsv3lYQcx7
         L9Usquk3KUliysoKUu36Y1DcFHQhrra2O4HhPPf/JnMzhjSgOcI9LLtJKihvFx0pG4kI
         tnpLCrpabniJzvauDWlHgA4YBsXOycvYhfMPiSULGQLuTrKZv76cz/t89HUURkP1Obiz
         YVGi0IAV7uJv+fqJMlL8/xvbT9SmABgIKFgEsxl89s6qJRmkiDq5vCkHIytf9ABUG7WZ
         809aXKNQasPesl04FHEo7vcVTGw/4XgFQJzuJWqQ094Yi2tBKRda4LVY3OMm02YlD35i
         KmVg==
X-Forwarded-Encrypted: i=1; AKwUvBzpYBRPK4eWwRplAPcHiXv5/xKMSUVl7kEXMqgYJULJXOKavITNsoHK4AImR2KhezUliON564mQosiNcJpIOdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fd34shwPgynnjiwTyC3sMb4tdfOFdibhXQleuQ7Ari5VvTrqU
	CT4+dxCl0gOOd8kXm0wsivi+qz+uXTh5L5pl5biJvqiMJdlUocqz460vOcLJ4jLDkP0c+4Zbd1F
	HgTPEpg8Mguv/2okEJ2uubnOuuLyLkylwo0z2GgsbmsNmETZX33FIzXoiFTGzxZmWXrIBixjYmM
	XrOlEJ92ODy43goIPpM+arg0oMjTOzQLZwHmEm35Hs/l5k6YLaAHftVo1m2Xk3v7duDHA26iMhQ
	AX55m4WUD3mVS7CzUVOWq0L9QU=
X-Gm-Gg: AYBFou1FqdiRt7GnjF0S6GYKjYOAnXzMEXdYg7JLBHf8oEjfBX0uYWazrOtEFTZX1ol
	jXLlTMyJb5r14lqpRm4Q6cbdAlj98s2XuldoQwyzEeWTmTmqOL/2RoBTEnZec998gOEc1v0M6ct
	Mi9uFtU+eena+0iOsvchbjdokTiguRd/r8zGVFbm3ilAHsk7aQnsSB1pp7tuKffRCRIUmRs+CRE
	5wI/b/sY3WkBzkuvCrxu+xUc2rf0GZN647uDxPjBaEe8EeWmkgpkNWpF84zNxs/qZUvaw//pAUt
	PKpuOX5KacgWdY6F3Lx+wq9mjAf2L0DLVGkps3LOoVjvH4OQJ62jtZFCl3Zhc8OGJV4HDZKmTgL
	6+NKj0HNEb0AspvEJWT16QSV65tLVtEcztB3EG1Oqd2OJY5HlVWnBJ2YkwuLxSWhhq4Fkb+RQJ7
	cQsHHF7JuJM4zeizrOtIKX/4ddISx0FprX9qgQFpw=
X-Received: by 2002:a17:90b:4a11:b0:3a8:c0cd:57f3 with SMTP id 98e67ed59e1d1-3ae896f8539mr10123889a91.18.1793714371643;
        Tue, 03 Nov 2026 05:59:31 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cdb36455fb1sm49822a12.11.2026.11.03.05.59.30
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:31 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a71dd190b0so2263253c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714369; x=1794319169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qngkg57Ni1YhWMlAtKTzwfofY3KWH3EsG38ilqqk6Gk=;
        b=RAZNGhkubzobtBl4XQ6QFZ+ZtDKkdhhSh6Cx9T8qqPrlLIpp2UDEVY6JmFOwtgrnMM
         TCmFIzXB8qTb8c2uqPPWKqn7c3x0f0JV2S81PvfAt+vtQYo1AMDSgKqQOh8fw2b44F3T
         uctOB0YWbGBqphDVaGgiwxPG/yYuj9s+Er5kU=
X-Forwarded-Encrypted: i=1; AKwUvBxGi79z9f5xcTnJ20SGvbIiivyEds1JN4ddlTEV5QK2cF4M73QngWMGt1gbglyo2CwcGyV3iTywec90/Zp1fKM=@vger.kernel.org
X-Received: by 2002:a05:7022:ec85:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1ac59dd081cmr26545034c88.13.1793714368853;
        Tue, 03 Nov 2026 05:59:28 -0800 (PST)
X-Received: by 2002:a05:7022:ec85:b0:15a:2b63:a0cb with SMTP id a92af1059eb24-1ac59dd081cmr26544986c88.13.1793714368146;
        Tue, 03 Nov 2026 05:59:28 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:27 -0800 (PST)
From: Arend van Spriel <arend.vanspriel@broadcom.com>
To: Michael Reeves <michael.reeves077@gmail.com>
Cc: Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	"Franky Lin (Zhenhui)" <frankyl@broadcom.com>,
	Mathy Vanhoef <vanhoefm@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	asahi@lists.linux.dev,
	Hector Martin <marcan@marcan.st>,
	Daniel Berlin <dberlin@dberlin.org>,
	Janne Grunau <j@jannau.net>,
	linux-kernel@vger.kernel.org,
	Hante Meuleman <meuleman@broadcom.com>,
	linux-hardening@vger.kernel.org,
	Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: Re: [PATCH 09/13] wifi: brcmfmac: Accept newer BSS information versions
Date: Tue,  3 Nov 2026 14:58:49 +0100
Message-ID: <20261103135856.3676311-6-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-9-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-9-b5cbc2cde2fb@gmail.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On Fri, 25 Sep 2026 23:43:44 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Hector Martin <marcan@marcan.st>
>
> The driver accepts only BSS information version 109, rejecting scan
> results with newer versions even though the common fields used for
> reporting remain compatible.
>
> Accept versions 109 through 112 when reporting scan results.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c   | 5 +++--
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwil_types.h | 3 ++-
>  2 files changed, 5 insertions(+), 3 deletions(-)
