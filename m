Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DB4D17B2
	for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832220; cv=none; b=G0XkRz/8EVpJlOj0ZYZXE/ByS/P8VJVzSHsptZIYyXPya4BIkKmnN2BlXpt0XkZ+8pngTcKOG+/7VKAJkYTwADjHpVCOmP9Kh7VuQONg4bRdVwPJUJSxXip+/U5rVTFo2IMbhz6cUD4VUI7NocU1dPvzaIoePBjE2if/z+8vgc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832220; c=relaxed/simple;
	bh=0++OQnsnodoFBA+6JtVfiCpmPpE/uYI2by4VMWbbVt0=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=En1VJQBPgA/AG8k9/rce2eWUFRBfUOazpq7C1MZP2Ev5O0GFv+Cmb4jUlXoS1ZlOwLfRboxBYd1TLFIb+YRfycriTkpHXs+uPoKQIEuGIxEivh03rwSKvHRl950Ge70hFkURaaGR1nNCeCba/qLK5OJYZMFQKFXQDQU80Qn4X+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=NOugOiSC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="NOugOiSC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48afbd2c386so1171022f8f.3
        for <linux-hardening@vger.kernel.org>; Mon, 12 Oct 2026 12:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791832217; x=1792437017; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7OMJ6SPz0N9qiO7f7FRcF4sIfMyC3KFW6sFDXfK2+0Q=;
        b=NOugOiSCTSMWU0cMd03TBYvIYlf1Jup6TameJJ/jlAiOUqVz5AEzKcj1wh0nrfhoBP
         K65eFJ3+E+qQXJ5nIs17eSlpUtmPtj/H9AOpsgG65N7cA/97zmwM85UbhEPBe8IybOxY
         utNor2haU2ekldstbHcxkI+I5d/CuOwXxdEs8c+PF+QcSM2V8IHKPY8tGCw2KEs3svwG
         3dEtw4zX5Pa4XKPB9Q4J/rS8+qGSg8/Q0iWQCSFMPOpIOQ43T/1DHUOWSeqq0x/p2OVu
         EsdwZ+JuHO9Y87Z93/DC8XkozO7xZZiklUfJI/SSk82y96QVosiaqM1F0RgHUjhmd4Ui
         l9JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791832217; x=1792437017;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7OMJ6SPz0N9qiO7f7FRcF4sIfMyC3KFW6sFDXfK2+0Q=;
        b=O1uCjKcFGMfkMfHQmoTOO6wy3gQfHOAYNdhVP+OiKxa9PDakpUwEbv+e7FFtqPYfLE
         IH9C1MSWqxP/6EHnG4oIhqW7mkFLOjiLPkHLMgKMxvntnBBIVGTks2t9U4CfmIhvtl0i
         2R8oQyEA3Ub+tuWUM+MeXPcWvCFp+wPXoYxE04kPjLFW9B1waVrXqSF0pMqWGHo8g4dL
         sUVrnp8GGUJvH2fjtlsxTzAQRmzgRjvfBQNf8zt11yR/wuYjtuD8LxJdDWOkP3JpNPFM
         zcoPLszbLxwUHlEbRkLnb+VLFVg5sur6wTieO0w+z6+PWYfAse90n8MejVkXwcnqy2h9
         mVmw==
X-Forwarded-Encrypted: i=1; AKwUvByNBM3uBK8IWvEkGOQXWhjh0/eQNU+ECSJVcC+B4ASO568Z/ofVy+oArAvD/94+wfbExTa0OVVJIncDkdnGu20=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYMnA4QfgOXnKRM4usCJDVJ8iiGMQW+wKjNpWLwqCS1O50NMEL
	8pwAbzZqaHg3xVRhv55wBQq2JqGVuh+OyfrdJa0Eqqj3LiFBHZm9dG691Ti8q4hZXJE=
X-Gm-Gg: AYBFou3GKNZnA4qHJNtrCD8Y+jCYSxjTT/0Ug2+GCishLEI4Qba0zaQU6bUzFJH+wvs
	JeK/fObCgZ2yBJmWgVYSQ/7RHfqCAuv1S5Njmbwp/rLPDwum1ajhRNYT7IQzWF7ThcCbDmR3hh7
	jTRhbTPIRxmk2vpDu6m0rx69C0902RbgPbGWQ9mVFSfugjQHbDBhHfN+E9TN28x7A4p22xzRgPA
	IYZE99UCSJ1MltprhHP8THLYTpnzsyD9uhQhgxouskv0e2JBh1xzqAwM0+ZHx7dx4EIUR9mH/as
	hC/7XBekfig6P6qiP7kCMnP0kLKIv9TqQ6+cLHLatK599BnM/VVEB/KY6IYLyme6IDXafn8MLeM
	3GB7uEGOnLxtcTccO5uvaY/7KWvmHFmrSMmjqBLEx2u7Oqo7TPNNAZIiGDXTZd1r5qm+ZVJi5Dx
	wZKGnJgxLPt1FIpSRefjVQpxM1D8fqx1zNuoLF2BJ6Pk2pXWR1kgwhNJY6FqG+/7t1w+aQo3G+l
	FLtyX0qrW9e4HX4gw==
X-Received: by 2002:a05:6000:470f:b0:48b:74b:4ce1 with SMTP id ffacd0b85a97d-48dbad00328mr17013251f8f.32.1791832217095;
        Mon, 12 Oct 2026 12:10:17 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de0bc91e2sm854527f8f.55.2026.10.12.12.10.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 12:10:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/4] clk: introduce TC9564 clock support
From: Jerome Brunet <jbrunet@baylibre.com>
To: Alex Elder <elder@riscstar.com>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com, 
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org, 
 kees@kernel.org, gustavoars@kernel.org, mohd.anwar@oss.qualcomm.com, 
 lorenzo.bianconi@oss.qualcomm.com, danielt@kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261012152408.3729237-1-elder@riscstar.com>
References: <20261012152408.3729237-1-elder@riscstar.com>
Date: Mon, 12 Oct 2026 21:10:02 +0200
Message-Id: <179183220207.266355.4262660703229090399.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1650; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=0++OQnsnodoFBA+6JtVfiCpmPpE/uYI2by4VMWbbVt0=;
 b=owGbwMvMwCW2VtK+WnvWU3HG02pJDFlnDXqKk5oKeaK1dwRzL8wylpbZcavZWlv3/rw1Mnpff
 av/c/zoKGVhEONikBVTZKnhrhZ/J6n1ZdZ0ndswc1iZQIYwcHEKwESWOzH893h4YJK4smjWDC21
 a2bH1i5YW3SO7U6qdqymb2FOrUP0Z0aGzV99tOwevdI5kM+o35D3p9jw1hGRoy41nO+2XlhzLsy
 FFwA=
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

> This series adds support for the clock controller present within
> the Toshiba TC9564 SoC.
> 
> This SoC attaches to a host system via PCIe.  It includes a PCIe
> switch with three downstream ports.  To one of these ports an
> embedded PCIe endpoint is attached, and it implements two PCI
> functions.  BAR 4 for both PCI functions provides access to the
> registers that enable or disable a set of clocks.
> 
> Both TC9564 PCI functions can provide PCI endpoint buses via
> devicetree.  Each PCI endpoint bus provides access to one of the
> function's BARs.  Subordinate devices (like the clock controller)
> can then be defined as nodes accessible on the endpoint bus.
> 
> Only one of the two PCI functions is permitted to define the clock
> device node.
> 
> 					-Alex
> 
> NOTE:
>     This series is built upon linux-next, with this patch applied:
>       https://lore.kernel.org/lkml/20261002181849.790275-1-elder@riscstar.com/

next AND a patch on top ?? you are not making this easy and this is mostly
to accommodate the DT change that could have been sent separately.

Basing on linux-next means there are other deps and you just did not explain.
This makes it very difficult for me to apply your series if I wanted to.

Next time around, please send a series on the clk list with only the 2 first
change. That way we do not have to cherry pick, we can use your cover letter
for the merge commit, which makes it easier to provide an immutable branch
to another subsystem, if need be.

*Clearly* list you dependencies if any. Please consider using b4 to list
the pre-requisite.

Thanks

-- 
Jerome

