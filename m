Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.228
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793714381;
	b=28XsmwStrVJOQYV0ubaxNitMbOaNRa93XE1QmQaRVrEYaTZVusxji/ntCudxI3KxJCU0
	 b3dt8wEnKpyh8w/kTOGvFSdr7rYo4lJIdPiISx1qCWlRn+mLQPgdrEPWrZqWfZL454Y03
	 4uxrCsAeiGOIUMibrERzO0Er1j2sCn0W8k+vF4sxHPaYAwOstLkmk904DdZQkT7tFnupa
	 yFOrpPBIOfDvIosgrNSrOGVwVOASSTvwOmvQowobHoSJoBWYTqdcfbzatfbcm10QPWmLO
	 ysTfe/pdxTUtILbvI4zXUU4BauaUWUryDsvsBJx+lPKKF/YNy3/BOtOelbHAtKcbk7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793714381;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=MKbHGKv5YTUZyLi0eTwdWhkz8iHCBkMeD/Uh/c0x5O8=;
	b=5LiczRGCLJ7p/RlBAguOsRHXIk+OMCAUE7IewoHda+6QNBDfZKZmu4N2ZQqdnSZttkZm
	 UczD5z3l3k8sLIcO+8FXqD3vE1rosYmS7yG5AwB7jL/yXOa4nejVBbKp/q9JwI43zC/k8
	 02BZVErniGTHaJ5g+cerOdMELSPpF5auGrgXccV2zoUr2FRmL6L3hcljdjRX1EXrZRnmZ
	 dvHREazOnkg32bGYAeeUp2J2OjSEyy1jL1DkekPMTNvnK96q/tgv2YnFTlpegldnhgqWT
	 EjWxCgl8lSOIOZAd78Kvi1PYMGs48twtjsELYCDMvME4YAGSvzVhFUcY9rlr3NTgmYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=en3WPw1z;
	arc=none smtp.remote-ip=209.85.222.228
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5E26082BD9
	for <linux-hardening@vger.kernel.org>; Tue,  3 Nov 2026 13:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD5E26082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=en3WPw1z
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-93e55db58cfso419110985a.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793714380; x=1794319180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MKbHGKv5YTUZyLi0eTwdWhkz8iHCBkMeD/Uh/c0x5O8=;
        b=XxAB4rXqpX1oO5mPPXSDHEbLbqekBxY1cZtT90A/3Bw4WZtpVAGBxuLE3i7hPeg7iu
         rPOsuwQ5ib5pddgdyzRyax1g3AYS8y9PpYOpRpqS0nJE1vEfLYshQFUdffxjO3c3Bq4O
         1UIxaypsT4FGekEk9Iwjzni5PCGsZZPpwvPd4MRXp8rAYQJ63XHaO3j9wqhrV4ye8YwV
         KF0LWuZYgZNxcWFcpR/1DSaM5QYYa3yDP52Z7XEh3TZNWxa2GHbVvMYqXGQSJje+5na1
         6s9Y1l1Oc/tgiB0WO/G1KZWysPjcmfOhDk8wSh0jjZ+kbTy8+YHJkp3jeg69TvttFbv7
         WRGA==
X-Forwarded-Encrypted: i=1; AKwUvBwtaI1cH29ZujWfpZrFzfbpiyBbJYgK9sFw/fYC6OBDEGj8v2aVaUH+LJD0YGXN1oTU/1EzHpctM7TIdlpmiXc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+UdH1CYqNJ3RNUxynkehHmphwZhqGlMndq2XUhvtLfzRgTDTYz
	ZcJI9Z5fsz9g6WrAkKwBcrOp+2/OOaSYeZkc6VCuWVOHWA2OEZFioVDnfSAxuMSRg7hPnVQOnED
	cr7T/5oyzVExu17zSQWUWxabP/n6uKwBQohw0Y6q2WUMGW0qri3nTZulhN+MvLLCZel7sV6K3UP
	f1L5IeM43vNNAw6JhE+fUNUIYEoT/kmAaJ7shk6URzJ46oByyfRSWfc3bGxT3hel28FhcK+hgeo
	70DLJoGt8CfX4+l8i/9MJLslxLeMg==
X-Gm-Gg: AYBFou1U3tFntNDhZWz5RqxFKHit+s+ZUIY2+C3LvcJeFMG2K9pwn36rIugaevcXBp2
	+C4WeOiWll3gj7dNlu5REprVdyNh3nQivAMhokAmvZhCuM9emC+HR3bJvxTv+TnP1ToS2SlDeBK
	ytiqsR2TKyfrE/61F/X5oW1Q5fTw7UroKRrAMP3TlxERNIs31uptdZHaloCVzp/IgKTBp9XhGOY
	Xosqt9ZIQB5U89HzG1PjyiKlJ15y5Rdt7Asarl0uqG8LaP9qSLePWBXl8FtIVB4QZCPDYlbtP75
	0M9tMJeCHUwSDVUL461sVqEIisT9rQHTIEm5gOfsmLD3spSCkzIwKuNlCIOXMrzA1ZaMcOvX+P0
	Ou0TquKgr/RdIrqygBzk9mXQUT2eVwyNxCTfWlxXttq/NU/y9cgF1/3F6kESDxmdCL7AzCSC6Gt
	QfKHOqt6JSXgpRdb0xQrcmqt+J0ObV3O2E9IK6UdE=
X-Received: by 2002:a05:620a:450f:b0:93b:be6d:4f3e with SMTP id af79cd13be357-9442171a2admr2218964585a.25.1793714379606;
        Tue, 03 Nov 2026 05:59:39 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-944258515d2sm110448985a.17.2026.11.03.05.59.38
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 05:59:39 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-1acbaf81bebso894104c88.1
        for <linux-hardening@vger.kernel.org>; Tue, 03 Nov 2026 05:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793714378; x=1794319178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MKbHGKv5YTUZyLi0eTwdWhkz8iHCBkMeD/Uh/c0x5O8=;
        b=en3WPw1zyGoktCfoGeKUdzD89gWlxRJysz0phYIbTUWx4g2Da3oZ1YQOcUhKeQDr0f
         njn6IFZW+FgFdCruMIKhu2lyZl0XRfUM3K/s5+0SfM4e74IVuWRYWr1DEwfQDnWPwQXU
         wmUeeBtnboIJC1V39trJgZp4oBBTxG8xsxRq8=
X-Forwarded-Encrypted: i=1; AKwUvByS6HsRdCeP7EBWU6yID5tDAr+Kr4nkwIMz4eRdQilHU/AupwR91u8b/BHkMCLL4EsryY8YTR++m1/XoDW29OI=@vger.kernel.org
X-Received: by 2002:a05:7022:2581:b0:1a8:7b58:6f1b with SMTP id a92af1059eb24-1ac5cfe587cmr24855346c88.19.1793714377483;
        Tue, 03 Nov 2026 05:59:37 -0800 (PST)
X-Received: by 2002:a05:7022:2581:b0:1a8:7b58:6f1b with SMTP id a92af1059eb24-1ac5cfe587cmr24855289c88.19.1793714376827;
        Tue, 03 Nov 2026 05:59:36 -0800 (PST)
Received: from bld-bun-02.bun.broadcom.net ([192.19.176.227])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm41658755c88.8.2026.11.03.05.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:59:36 -0800 (PST)
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
Subject: Re: [PATCH 10/13] wifi: brcmfmac: Support versioned scan parameter layouts
Date: Tue,  3 Nov 2026 14:58:51 +0100
Message-ID: <20261103135856.3676311-8-arend.vanspriel@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260925-brcm4388-submit-v1-10-b5cbc2cde2fb@gmail.com>
References: <20260925-brcm4388-submit-v1-10-b5cbc2cde2fb@gmail.com>
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

On Fri, 25 Sep 2026 23:43:45 +1000, Michael Reeves <michael.reeves077@gmail.com> wrote:
> From: Daniel Berlin <dberlin@dberlin.org>
>
> Newer firmware uses scan parameter layouts with version headers, wider
> scan flags, and additional fields. Requests must match the layout
> expected by firmware.
>
> Select builders for versions 1 through 4 from the scan_ver response and
> use the selected layout for both scan requests and aborts. Fall back to
> version 1 when version discovery is unavailable.
>

Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Regards,
Arend

> Signed-off-by: Daniel Berlin <dberlin@dberlin.org>
> Co-developed-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Co-developed-by: Michael Reeves <michael.reeves077@gmail.com>
> Signed-off-by: Michael Reeves <michael.reeves077@gmail.com>
> ---
>  .../wireless/broadcom/brcm80211/brcmfmac/Makefile  |   1 +
>  .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 203 ++--------
>  .../wireless/broadcom/brcm80211/brcmfmac/core.h    |  17 +
>  .../wireless/broadcom/brcm80211/brcmfmac/feature.c |  46 ++-
>  .../broadcom/brcm80211/brcmfmac/fwil_types.h       |  65 ++++
>  .../broadcom/brcm80211/brcmfmac/scan_param.c       | 416 +++++++++++++++++++++
>  .../broadcom/brcm80211/brcmfmac/scan_param.h       |  13 +
>  7 files changed, 594 insertions(+), 167 deletions(-)
