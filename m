Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714405;
	b=yarbBnaMxs7EYJYhwlRSLi4JS4LmRwnJhqPeHeUhEqshjTIt5+ATiiJ5tJos5RGL2Rb/
	 oTYAodGLrzQwO+T9Nv9TRTtSOKLTfMBRwKhJTXBZGA9Vq9SbMCtQJm3KJQcxo+RXu70aq
	 g/Q1WklHvWh4nwOwOou2BB1Al39TX+FY/KGRIA/uc7xCVbpT8/NiGPZDRl4Vj2xfldMQW
	 VTL/V/+3VNeCZa+RJQat3J0sX5LD0WX/Jd+29G2UdqulASej5LdOR5qThjYAludV+uKk7
	 GkKmqUDB/oiNn/t6QkKf1Tm5IQeBfwvAFb0bi1wI62uSrV93iCF5IUNiCqEfMEn9l2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714405;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=qw4Aw0jcq5gAZzmvQPuYkoKDSkJMWpxQEuocOLkzgts=;
	b=cnJh73sU0KNF2Ti18YQGZecJL8KCAlhTT4PktMpe1EUm0XowxIWFvCJKr/YLRgUEbiBt
	 w+zoN0POHS4iImBsWzrm8n8fsMN6HxqQc43glXcL0tOYKWuLC6QS/aXovk03Zp8RiJtjp
	 C14HdNGrivhgN/ho8gXSmNd9YX1neTwf7AdR/CgHA28eUZ8irMsQqCHCkS7gLloKi0epD
	 WNCGVwVPcTH35nmjM2fE7h84tk+YArVOGmlU4lIhw6hTJ+NwMaALoRnWOT8EbBgzWD+MB
	 NTuJw5IsmLuMIEad7nq3zb+RT2zRweTehs5hDpIIhw4+c0zNjCcZkE6Z4TeV3PoINyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bsXp1poO;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740960A260F
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 14:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C740960A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=bsXp1poO
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1810326a12.0
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 06:00:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714404; x=1794319204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qw4Aw0jcq5gAZzmvQPuYkoKDSkJMWpxQEuocOLkzgts=;
        b=w6bxuknwsmYCvvClKXtEGmaVdOh0T9CAp3HZeCCF6ywxXGoR33lxgZzo7gHcVfkCyl
         nCsby77YU0IqqtVci+Hu9IDNV493muvj3wQsdeWZA5V+JDkV34GYgZLFjHJW1u0cdUGG
         EM0yl4YpsnRv+f2ra3KQ89MHiQKIWrK/kJr8uJCVPEZcBIAMRunAyRjjRKMr/FHt7IEU
         ZHjpdmtaeZXwH28+pNkIva1lQLTFqQszjWhz0SIhItzdEPanWikrj0aAAqtzQveS6rWi
         S5yiKm5WwaSdWCWzqvemGAtqHIwG48+rVef39GADBzKOJcmNckp3Kqsoj5eWjWIN2UYN
         S3wQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfmm6TML6zmxTDys+qpJwgQcwu9Gv4w6XosUQmgfEEHQYyWUmqs8hpCtlshSIeu0OA4pYraUC+vc32ocIaasA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SqFEMcJA6lftSp9QZHAz2V1WfTFRyAG4WR7Oh+BsLXfcYk0n4
	fUoeJ9KGGC4l8I3aLXDsvUiNVY03Cc1XrJn3hW9KpgJzC0HSVkxgpPNSi+O/0/TmfhDWNXZ2JYP
	VZZIdyXhjsP9FUwaOWDsGPWRIFSkcT47xjox6eCEQLxjrAjk5vlepByjaNJiTqPjVq5LAEuQnwx
	iaSsa+Gm5ANxya1676bhIHbEmkmJA3Pak96R8SLAmd8p9nDhcPBGcCTUrIRNUjQlw+IJKDh4qwI
	aFsfm//g4+UAfM3TbyG/nngwNuSag==
X-Gm-Gg: AYBFou1t8RKQLinCMV+lcStOqCUHdxhM1U1EDWdVHue57EKp+yKGBT4IPln6kbsvNBy
	2xRKdDHtSLXia8/NDhwoZkpdcrydaYIrd75wJwuKIO9MRNmxHyqDmfSGT8ArgxKclSBz90Wzrp5
	hT4TxZEAc/XyqexcgUzPwdOmyy9KJFzqhfqyADuY9r36PmiaaWTyVikqdfKbemi/vCw0aCY4ciN
	yNuS7p+Wb+3tTiS89ml6RoqwPH1HSvTb+MtIM+j9sn7BpnOtt45W2UkBwEEYyrxGnY5ngO2uemM
	POjiHY61hZ70wozSKLm2drS7fX4HY1hF8zcr+PVwJij2loI+39BjS2WkTCr8iF094EJ/+9CvpIC
	xAS6ChED9wKOlHJgvpCXZkJ3Bt7WcCV2LBappJMWjG1/sqXgoDiHqQmXgsOHw4Nd313uEv19q1E
	Zh1hh4RFSZMK1T7uV6qvd8l2jaHzkWSbWeM7zq8iU=
X-Received: by 2002:a17:90b:35c4:b0:3ac:3e42:60a2 with SMTP id 98e67ed59e1d1-3ae8982a538mr10238861a91.33.1793714404130;
        Tue, 03 Nov 2026 06:00:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b07c7ae5besm2009242a91.2.2026.11.03.06.00.02
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 06:00:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1b20a4b5f2bso2140043c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 06:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714401; x=1794319201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qw4Aw0jcq5gAZzmvQPuYkoKDSkJMWpxQEuocOLkzgts=;
        b=bsXp1poOV8qg0cdbZn14/0NL6F0eOk7Sdr1LkDO9dbMo6UXkRW/NLAOXRO6+WfO+lx
         pu36WNwOA7kC/Iw9V+lo5rjvl2fqueUMYHKEZ0aNte0ohmIvIkppUOkxQ8hm+5VO5QaZ
         egCnHKiH1Ulv97Ufza+R/mTLjWUpAOiCdSeRs=
X-Forwarded-Encrypted: i=1; AKwUvBy+fx5dMa4RRHewC6kfnr029u5Zp3zSx9gdtvAQiadZeNPOJ58DYnqjxqF49P6j/YfGsvfoLy5TU8Ybq4kJgPY=@vger.kernel.org
X-Received: by 2002:a05:7022:c43:b0:1ae:b906:7733 with SMTP id a92af1059eb24-1aeb9067966mr14495781c88.23.1793714401174;
        Tue, 03 Nov 2026 06:00:01 -0800 (PST)
X-Received: by 2002:a05:7022:c43:b0:1ae:b906:7733 with SMTP id a92af1059eb24-1aeb9067966mr14495751c88.23.1793714400382;
        Tue, 03 Nov 2026 06:00:00 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:59 -0800 (PST)
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
Subject: Re: [PATCH 12/13] wifi: brcmfmac: Handle extended PMK command payloads
Date: Tue,  3 Nov 2026 14:58:56 +0100
Message-ID: <20261103135856.3676311-13-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-12-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-12-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:47 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Michael Reeves <michael.reeves077@gmail.com>
>
> Some firmware rejects the legacy BRCMF_C_SET_WSEC_PMK payload despite
> advertising firmware supplicant support.
>
> Add the extended PMK layout. Try the legacy payload first when the key
> fits, and retry with the extended layout only after -EBADE. Use the
> extended layout directly for larger keys and reject keys that exceed its
> capacity.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 39 ++++++++++++++++------
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       | 18 ++++++++++
>  2 files changed, 46 insertions(+), 11 deletions(-)
