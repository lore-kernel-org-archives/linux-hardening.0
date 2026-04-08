Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F7A3B0ADF
	for <linux-hardening@vger.kernel.org>; Wed,  8 Apr 2026 14:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775659767; cv=none; b=AHo6DDvI1NiDY5RXOUbcP3EEoVftNebrWQWJLmtvNn/mAl2Wup35oXJsVcUy8+n3ylhG9nlQlzo9plkrTormR5bHdMs4ssZDnhSKrJGtaYiASoeT2/7DJmT683giyMWmSZ/L8OdzmpH3TXUTAgTDQABc8eoEs3b0qJxX4X6KSrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775659767; c=relaxed/simple;
	bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=lqzqpJyqHae7RQ3YoMAnIMbDJlV/sfH3ALdDGvSQBIFSX5ggxtdVBjCZ3203pA7h1YXvpR3iZF8j2fB/73MJBu68THJs7EVdJyFTxl9YLqFdazxQ9mp71DEy+BNHG2Y6Qp3NwxIzHCayGUMllRSoVez0Vr6680nI2Bh1BrEWix8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NZBqGxwQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NZBqGxwQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43d43e09de5so1597498f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 08 Apr 2026 07:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775659764; x=1776264564; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
        b=NZBqGxwQa7Yi+HoWDlbHzdr8kfrEjy2wYzpIDKQsN5HRVoPjsOlu2cZc8JUh/RVHyO
         S153dvYOW7qj5l03qYuxav89jjBuphJwHpd5u5MD9XtDcqDKO3NklC9c5SRZzVoykN3p
         nZ28jiR28CutpJdpieCgPO6A1vsv+a0qz29eJl8EgGCZ6+mcoveySnzAZ73yDm8pqb+d
         T08qfHEHbab+TZKR6Bncnas/Z4Yi/LSSV7ajGhw7ry2/9rzdlnPLhHeFkzMR+46h99Er
         CLEG8CSlU8qtTJeNZ00DLEhH3zMOME68L7XrhFDgBkn69INy1pWnP+zUZBBysBaF5SG3
         4JPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775659764; x=1776264564;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EQsRJiGkX5iRTB/AZVv6hwVd/Kx+flU2pF6ssQXU+8=;
        b=QJZamG1vPOxq78a7Ztf79fgvYYhnKm4UPodRlzs1ga8b7zXyuEOOQ1zZCmToNSq1aA
         Bex6I3upso1Laqyoa/bsIZAlef0nKCxnX+/RYO5OFHPgoTFzFAccW2k8msgVJhyKKm3X
         jdkHhx5RTY2OXD9LS4r6HNCFsOlXQ1k5ENjLniadi0GR025f8fgkDUMolvSQ9tGSVJRq
         GOj2XuagOFQKcbG2a4QJBSJ9pBRZLmmuUWaxbvj7QHfvNZFJ6LmP2IrnQh14Zq0oP8h+
         oCvr8JZr3Le7m29/FjFVCAJUw3UT/dMcOAdXVcSJ8O50XhTA6e33xTBk+7zU4hZSx8KI
         Et4A==
X-Forwarded-Encrypted: i=1; AJvYcCU6zBjTNbjvm8cz/F3Y2sACI0eue4Y4qoNJu0aH/qnFWZN408wMc2d5wmMKbO9D/l7yWNNNQoLmXJjBZqYfka0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqZ/4ogz2PRwnCz3+6+VaPWVoVmtvCK87Hb82Z+wGeDF7U0nM
	vjrPi/mOdENsN+2v29XtE86t77QcCt8Ej15izO0To0k/3wkw72APmFMwqwmlJA7DtVw=
X-Gm-Gg: AeBDiesKVvObpeHGYzuPs/dJe3kiN3ybVTqIB33yWP6NyY3gLbBn7nP6LVwYvSjYo7C
	lLBqfrpkv/8muNvYusQB6Udn+jYAy2SgcwjAe57V5Ff8Dk281DVJ8CliqazY8ohOg9lzCcg6Q+v
	GEuCfgPuyfQZ4T9CP8EjGbSepvO/SCA+Abff85edEclxbSe+7nQjqRBjaMGJfI6aYX07iYBTJDp
	bkXMeTZwEWNKfHYZ9CZXUJMewVhsp8mdgcit5PFc3EdBQapTiPRJkTg+IMoFN7PohOr/pRpdnvw
	RB7DqnL3KslvjjYmlFsjS9LBEULwuxsubnHyqSFJGA54lHMEuP+Bi/K5IvFeRbdWLUpMlLcjajS
	n24ij8+LdrQSUn2RU9vuHftVmhLwrr0G1ut0ZAz0wyjHmA5udHEuK4UIr9TssG1anZESYvwD/+4
	dvST5HLpDF1P+gDd4Ml5/WAZAiIZ4RVcpMlQvavD58DxXJsHjHE7P86+l2gUDWPVB9K/HwC4dgu
	mqb/HNY99vM8OTtbQ==
X-Received: by 2002:a05:6000:2885:b0:43d:1c21:ead4 with SMTP id ffacd0b85a97d-43d2927bc28mr30909918f8f.18.1775659764374;
        Wed, 08 Apr 2026 07:49:24 -0700 (PDT)
Received: from localhost ([2a00:2381:fd67:101:9775:58c0:569c:bd74])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e5890sm57988952f8f.31.2026.04.08.07.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 07:49:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Apr 2026 15:49:22 +0100
Message-Id: <DHNUUPQPD5DR.18P18VV0LNTI8@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Daniel Lezcano"
 <daniel.lezcano@linaro.org>, "Zhang Rui" <rui.zhang@intel.com>, "Lukasz
 Luba" <lukasz.luba@arm.com>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Krzysztof Kozlowski" <krzk@kernel.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Bartlomiej Zolnierkiewicz"
 <bzolnier@gmail.com>, "Kees Cook" <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, "Peter Griffin" <peter.griffin@linaro.org>,
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 <willmcvicker@google.com>, <jyescas@google.com>, <shin.son@samsung.com>,
 <linux-samsung-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] thermal: samsung: Add support for Google GS101
 TMU
From: "Alexey Klimov" <alexey.klimov@linaro.org>
X-Mailer: aerc 0.20.0
References: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>
In-Reply-To: <20260119-acpm-tmu-v2-0-e02a834f04c6@linaro.org>

On Mon Jan 19, 2026 at 12:08 PM GMT, Tudor Ambarus wrote:
> Add support for the Thermal Management Unit (TMU) on the Google GS101
> SoC.
>
> The GS101 TMU implementation utilizes a hybrid architecture where
> management is shared between the kernel and the Alive Clock and
> Power Manager (ACPM) firmware.

Do you plan to update or work on this series? If, by some reason,
this series is postphoned I can rebase it and re-send, for example.
IIRC it needs a clean rebase as a minimial change.

I am constructing some code on top of it, so it will be nice to have
newer version that can be (re-)tested for Exynos850.

Thanks,
Alexey

[...]
