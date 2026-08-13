Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E25472F9D
	for <linux-hardening@vger.kernel.org>; Thu, 13 Aug 2026 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621980; cv=none; b=cuvSnvB9zyTc9kREdtsZjLPElVA1c/aaeoAQYE6IyNNVr638d47zTy1oBooprOPiF5Lnu+MyPp6RtqDMt+csJeVZm9qr4n5L3tiLatgkbc+8k6K6GkwmjZSYjQ7IbiQgdy/PellXKW3S7C9cVXvFAEoTy+UfUixWabo8PPUPFBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621980; c=relaxed/simple;
	bh=3+mL7sLw774TWm8srN2xcPDLwTpzOXiXFyMo1RJsCVg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sDeQXnTtlQU4QOl1pPq17vp9/Rn2pWQ7YQZ1yuV4ow7rx0vTQkB+A6S9m3L496RqUW2liu+2JHc42NLb0rTbx19YAqEZIrdbYA6599CCFhRgE7cU/Uass6Jmo4ij3Po8jFe1bpGAX+CQvvbWcEQnijPDNkIq7yHuT5D7bGwx8jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k1apJ9LV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k1apJ9LV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49978908b35so15257315e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 13 Aug 2026 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786621974; x=1787226774; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3+mL7sLw774TWm8srN2xcPDLwTpzOXiXFyMo1RJsCVg=;
        b=k1apJ9LV3PV3h+qr58bcA94CHzubTPuSFKv94hxj76CLTNcuE1J7AC97EynuvO2TJ5
         /foh9ocA4+OLI1jv/iPseljCcDNyHmRuNpOe3x57imNW6/FP+fj9C9egfBQ9QnEBIPbY
         MgrERFXNvIe0+ZZc0LhUA+nG9cYKv4ikbwhoyyYPzti8D6uSDLal8pS3mayJHdYktVRq
         hqAmmDyLI+98nk4zErP03mgrGZ64zvNnQ7gaahZ3sVR+zM4wXHwiCbKMstZX5/CpoehJ
         1ZtqpGwbo3v2ih0LbptVtVL6PyPXYdv3DUl+uoC6eBvjv+UH/wr9gsrSYYO3LOBV2nP4
         kcoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786621974; x=1787226774;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3+mL7sLw774TWm8srN2xcPDLwTpzOXiXFyMo1RJsCVg=;
        b=k++OHpxDinIgKp835fYHooTYxTGocUiOn0OSW0rARbdXweKbMdvmfE3WX5DPq0CPP2
         e5PmeAfkfzY4kwPzOseVnpKcgv+W7AUDl4kKzyRA2V+wJFbjMzUYNgnH41w+fZY9EaPX
         9p03mmsUAgX/80A+/U/3uKOuyZ5ayUvaz2NNzMaM5qicvd5m0XUx5ToZpSqk/dh1ywMY
         nOmABRe+9P9RGiIqroihuh55ULGyHiidJ0uaQskFkUs/C/S4P1NYfuFTDp+73crTVcAD
         n1UEQasYG1epSqDxygX7kVRy5M2llNy9UZUKN22/yIPwn7jmRqaGPq1irIp8dw9fn2kS
         inmg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6hYCXPz+e6H9TXX8nZtJyXfwk0DkuHtTTc2UUcdi+WlaAVMoiaa6EKiJNijuXsf0N3rWisdKY2JAQu+H/CFk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HJ/aZwnJ6XRY1O7xBia1LVzoBz3R9yv4HMN5yMXlCVI23CSJ
	3R6f/7BeqFrrFIOq6O49usRFc5Lw5kQaN7E4rKXfaC7CxO+uYnetwt+p8+yv2E/wk0U=
X-Gm-Gg: AR+sD12T0Iz0vEIuVJ/5PXuWuWHhf+xnLPqoDmiCjeDyAB0Vz9ay9H917BOI2yPbphl
	rBZSsMEqEv0Q1zFHY1Z1LK6fySd02e4+2WWtseC5b4rJFn2nj+Dt8soRCf6Poai1hkrBQA5k1yJ
	QhBG1kpMrITWzlfhA9nh437M6AeTBYmu+dUMP+2rg7niZVYsr5jaVQ4hDIBueAvk7J5Vlf32ymt
	/k/4Ca2Zd54tpP22kqWL35IXetOi+pmFmb+HOFMM3uWevnqhh3uK3yVjw+PKoAjhpOoLNIPz4RQ
	1hzAfDpHkSOqp1UulkC7qHVIqVPomCqnzYAPgxuX9dXU4coIxV0scGOi/+encCOGJop7J86qQOH
	R6b5OhqgYFtELnpOHgmM3Efyyq5l+r4hLunWmuG37cDkwq33+PNRbVX2nL2al07XfCOOvRo4aEH
	YQBJRv0pv1aamD2HZMk0asKHGSC31jrrc6B4kgU8rGDBOjsZ0d3lbO5IZFihvhtVFx1ZnMAUX/g
	HcIKH2HwEV7CUOmWLXaJkYNYwSSFiC8gey43vG+QDaYEWhdI+LbFhcdmbIX0uEz
X-Received: by 2002:a05:600c:3153:b0:499:7ce1:d8af with SMTP id 5b1f17b1804b1-4998219bd2cmr62067605e9.1.1786621973610;
        Thu, 13 Aug 2026 04:52:53 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:c11:afa0:9e5d:4eee])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f4afsm72097455e9.5.2026.08.13.04.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 04:52:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 12:52:52 +0100
Message-Id: <DKNSMR9KRFQH.3SQDYW46B42FV@linaro.org>
Cc: <jyescas@google.com>, <linux-kernel@vger.kernel.org>,
 <linux-samsung-soc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, "Krzysztof Kozlowski"
 <krzysztof.kozlowski@oss.qualcomm.com>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley"
 <conor+dt@kernel.org>, "Bartlomiej Zolnierkiewicz" <bzolnier@gmail.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Kees Cook" <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Alim Akhtar" <alim.akhtar@samsung.com>
Subject: Re: [PATCH v8 0/5] thermal: samsung: Add support for Google GS101
 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Daniel Lezcano" <daniel.lezcano@kernel.org>, "Zhang
 Rui" <rui.zhang@intel.com>, "Lukasz Luba" <lukasz.luba@arm.com>
X-Mailer: aerc 0.20.0
References: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>
In-Reply-To: <20260603-acpm-tmu-v8-0-0f1810a356e6@linaro.org>

Hi all,

On Wed Jun 3, 2026 at 2:00 PM BST, Tudor Ambarus wrote:
> Add support for the Thermal Management Unit (TMU) on the Google GS101
> SoC.

AFAICS there are no new comments and no updates and Tudor said he is
waiting on feedback from thermal maintainers (for 2 months now),
what's the status of this?
Apart from some required updates [1], [2], is there anything else should
be updated here?

Best regards,
Alexey

[1]: https://lore.kernel.org/linux-samsung-soc/08d7299968e14e5fc07fa4791479=
abd9a2b11c2d.camel@linaro.org/
[2]: https://lore.kernel.org/linux-samsung-soc/DJHQR4IAYPDF.2BOI33M1O4CMO@l=
inaro.org/

