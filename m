Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F3D542EF5
	for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 19:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791921217; cv=none; b=LEE7kz6xi1rmMk2HjrpnkzKSk6CchEPqLZNziEus612/FFGsuDkGTgllBtrKRhaRhD2Q2lZ/Fd1hcT1RNkY67kD6O696XWjZ4a7KKBc3Fbr6StzlhkBI4n+FZVbrr2uJuYiICRneCcnUix2h1V9WFDrFPqCoElUt9IPSz3Ke17Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791921217; c=relaxed/simple;
	bh=9X+B3VzuP6c2+GbMDzQKaInOmGWlAa6Crsdlsjiub+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOXdKIhCmaVI4kRojfLmIpP9RNq0HTISXt/5e/9LU1XNJxEsSD2ta9h8PsaeT2PAOxv3pAbfLUEzTvxFO7YOe+h+Rj7FIPPZKA1nH1POpQeKikXDmwIrCFI0g2FOM2g2UnLqgDm/wB5paQbGgZ9dp5KDchiR2H58LK8v8mWolrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thinkoid.org; spf=none smtp.mailfrom=thinkoid.org; dkim=pass (2048-bit key) header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.b=EPUCk5Vh; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=thinkoid.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thinkoid-org.20251104.gappssmtp.com header.i=@thinkoid-org.20251104.gappssmtp.com header.b="EPUCk5Vh"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-91b89c6caffso17226606d6.2
        for <linux-hardening@vger.kernel.org>; Tue, 13 Oct 2026 12:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thinkoid-org.20251104.gappssmtp.com; s=20251104; t=1791921214; x=1792526014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HcBu6oPAez1ljZeSMUFIBe+d1rm2GYp83jcwBgf/ZWA=;
        b=EPUCk5VhzC4xZLPu5RJNFkGJNQIaQGlNdADxDxWxR//Q6VGL5HifvRB4F1j3YoqkIO
         D997XkDKGrvbKBkYRhUaDKBlUsJKe3qweZTasPrGov7LJl6T9VnlZ/jVEL3do5ifowEv
         KFFBa3pDn/YlhqbEdcjCbEbwnQAYj1+yfWPEn6L6CDGymP5DPD3zhoRoqvLcgCmEBvSW
         6fqfOsaR0+AOsXCEIIGG7hdUpfMQPJ8BTW+dXRpg266MqkkZ0wmvoV7/Q2/4++21uc1S
         vBq7Wsoi5aVZFMUOpNeRoHGu7kvF3OoQIT0d4xY1dE/HBSO7RL9fVox9wAAAgDxo/q9F
         FSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791921214; x=1792526014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HcBu6oPAez1ljZeSMUFIBe+d1rm2GYp83jcwBgf/ZWA=;
        b=0DoCziJaF323uz27xqObvAwPhKtC/81LuEr+YlMSKVxXFsEF4+nmEFnrkRXO8tmgTX
         uaPCQZ9i/TfIZsq5BrlYTV9cEQp6hNtSZiJ8FQ80Rn5ofsVTj3n+5mzsQsboZUaR7ta8
         VwCcqZn8m02WW/lDaYK7F3lPOouS+rzE8Y7u6jSO1LtGtq+ONFXxIv+Cu5rQHNU5MWGu
         XUyb6FcXa1uXA25OjSOodn4VwCrdS0G2yWRAtVMawkVR2jBxNuqqahL+hE5bWnfw+bYq
         XBxTGOh4gb1G+SSM8wIJntTrguvvQwc/BOGu+qeVQIlSFreImX9jOCVK6MgCJC8MTs6Z
         on2w==
X-Forwarded-Encrypted: i=1; AKwUvBwZogb59DkN7N1cG6dXIL9vNPSy71d0KOmNBmqci/8W5bX2yd8KXVQo9zvRCMJaXw4mgSnRYDdG9tUIVU3Un6s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQAmMfe2Z2d83diZHowBJORFpolkBL15MMo1cWNrtwaJPb88B1
	LxOKxNj/iz3BkTw7MCk7SPpB1TvAUenpDFIm9G7ZPFoQXXGLAhzLvBLFTcvGK5IiAhc=
X-Gm-Gg: AYBFou1vjnqn191Y+avW4ZZC5ViIyuEHI/bPKpOhpQF6t9PP7oXw0JqbzXBUHR2fpEc
	gZhNd3bN9cc67ePGfT85oZEOzsBgu1u8r3If/1bm7nIEq4fpI0D7KGDdwA2wRpS23l+80A5i09T
	lYO2OR1w+6qaYc318w86nLMwwdJEl0eUu/musyzzR2InK+x4dIbk2DCMKsjM3QawZkBhX2Rn3pB
	1WB8eq5msA9llHe1LMEfltCT7T5VFXMXPpClR7ifM4mpFrxDWExenpZnLxAeBxbp5xrsd0OfFLH
	GgzcrvGLwXbEMK5MwfdH949qW/p16m6OlFExOJF3AXNNZFvy5xnUQQ5hngcvflxjPvtFcHwKXDy
	IhmfFWptVpOInt1C9vGjzc7FbkEPA0C/kB+xxu+U7TqzMX6y0HRK3BuYrMZ61Ol02aCDVV2OJFC
	Ojnd4nMT+dQxWJOXnIctatsFIv3f2TrOrXfwMORK0Ws8t+2sG1AMz3rX7XY9RZEC6eNQCcVA==
X-Received: by 2002:ad4:5fc9:0:b0:91b:8d12:bac9 with SMTP id 6a1803df08f44-91b8d12bb24mr93591896d6.0.1791921214109;
        Tue, 13 Oct 2026 12:53:34 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:a61d:7a00::11])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97c35bfcsm33085666d6.42.2026.10.13.12.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:53:33 -0700 (PDT)
From: Liviu Nicoara <lnicoara@thinkoid.org>
To: Michael Burch <me@michaelburch.net>,
	Aleksandrs Vinarskis <alex@vinarskis.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Tobias Heider <tobias.heider@canonical.com>,
	Val Packett <val@packett.cool>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-hardening@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: qcom: x1e80100-dell-xps13-9345: introduce EC
Date: Tue, 13 Oct 2026 15:53:27 -0400
Message-ID: <20261013195327.19571-1-lnicoara@thinkoid.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261013172718.12355-1-me@michaelburch.net>
References: <20261013172718.12355-1-me@michaelburch.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 13 Oct 2026 12:27:16 -0500, Michael Burch wrote:
> These two should be AMUX1_GPIO and AMUX2_GPIO. My unit (BIOS 2.14.0)
> shows what Liviu reported [1]: 0x14c (lpddr5_therm) reads 130.048 C from
> boot on, and that is the value the EC is sent.

Same here, and the ADC1 table settles what my readings left open.
On this unit (also BIOS 2.14.0), with all four GPIO channels defined
in one DTB on a 7.2.6 kernel:

0x14a  38.6 C        0x14c  130.0 C (constant)
0x14b  32.7 C        0x14d   34.7 C

A charger on the left USB-C port warmed 0x14b by 1.6 C in three
minutes; 0x14d stayed within 0.1 C. So usb_charger_left_therm is
AMUX2_GPIO, 0x14b, as your table says; 0x14a reads a board
temperature and warms with the SoC.

> +	sys_therm0: channel@14a {
> +		reg = <ADC5_GEN3_AMUX1_GPIO_100K_PU(1)>;

One note on the shape: hamoa-pmics.dtsi already defines
channel@14a and channel@14b as pm8550_gpio_01 and pm8550_gpio_02,
with gpio3 and gpio4 in high impedance for them. The EC's io-channels
can reference those two directly; redefining the nodes in the board
file only adds the labels, which the EC node does not need.

Happy to test a v7 with the two channels moved.

Liviu
