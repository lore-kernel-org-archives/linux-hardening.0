Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F54F4E2
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 17:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HHAyVisP"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E413E
	for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 10:16:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40836ea8cbaso13994835e9.0
        for <linux-hardening@vger.kernel.org>; Sat, 21 Oct 2023 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697908588; x=1698513388; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkXQx7i5+joI99QFWucS4PtQe0BoKp/UAVRxKkG1Y/A=;
        b=HHAyVisPz2ANh7/joQB0REWNEDV6tCoVxuGc8CiZakevlWWQExdX94XDNKnp9aF0/V
         jd7XWYEYHjpwnQb9Fs5S9CCcZKUS1oyElWlndZJ5tmtxa4BoB0e12ITTk+LpmuerHONH
         XHITa5jzNc0cMIp/gv0pMiEDK9pul1fEtbj6ppaI1gXV1TWf/k8qS4F0HuvNOZtcceuv
         quDrHrWLVpVo4C2tIRt6sjeORmJnkoi3khmJbBeBrP1j7jUDAnS9Xhbfw2akDlHsIAPU
         jHLO5aa/za9XrnNTfMWdnEjtj1mXLMGkd1LBwf8hsnrMZUuY3O5a/1R0setxdyFzqgTl
         j3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697908588; x=1698513388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BkXQx7i5+joI99QFWucS4PtQe0BoKp/UAVRxKkG1Y/A=;
        b=WR/VGxowkc5Fz+ve9gLE1cIodTYhjzhIQXz3GuE8TDLGWrEB+8sJ5+qGRQflAi92tx
         RdJKd6jfLsWoKLOk52GVPztGAuF+n9KAHG/lz33x+KU0JNPp/wXL8nBgNf+4G8U6lJAs
         Kwrmcu65K2YlRaki7F6V5DzubiEdyQCAKVVXOCEhA0aGi54+xLypP6iMHoq/U4b/VG93
         61upjoE3x5FeECOCpaPtPN29V6jcjC5qoe03zbr9miV+SSLZv/M3GWCyTQgSKV2uqz6f
         p5+ReGQG/dydIaLnAhm8llRfQvEeRlHtxtePrPPDjrEl+hkdr3MRt010h78pbPd1Y7W4
         RU/Q==
X-Gm-Message-State: AOJu0YxJZhevQsfQ2s9Tk9Y78vIKa/HMBNH56RRDkuhbHN+doXfasBGY
	IzMEkgUU732dDcC7Sb2q1tBHVQ==
X-Google-Smtp-Source: AGHT+IGPAXCjaKUWsb322iXCxKdJXTs27XmdUwvdY7ChdMh9tNV7eJ5t7QZZ+qFcMEAX0TXTuKcyCQ==
X-Received: by 2002:a05:600c:34d0:b0:408:3f87:cba with SMTP id d16-20020a05600c34d000b004083f870cbamr3579939wmq.39.1697908588409;
        Sat, 21 Oct 2023 10:16:28 -0700 (PDT)
Received: from [10.66.66.3] (9.ip-51-91-159.eu. [51.91.159.9])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b0040596352951sm9597405wmf.5.2023.10.21.10.16.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Oct 2023 10:16:28 -0700 (PDT)
Message-ID: <5d537b3a-91ea-4a2b-829c-d5218041291d@linaro.org>
Date: Sat, 21 Oct 2023 19:16:26 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sm8250-xiaomi-pipa: Add initial
 device tree Initial support for Xiaomi Pad 6 tablet, that have sm8250 soc.
Content-Language: en-US
To: luka177 <lukapanio@gmail.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <keescook@chromium.org>,
 Tony Luck <tony.luck@intel.com>, "Guilherme G . Piccoli"
 <gpiccoli@igalia.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231021164654.146002-1-lukapanio@gmail.com>
 <20231021164654.146002-2-lukapanio@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231021164654.146002-2-lukapanio@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/21/23 18:46, luka177 wrote:
> Signed-off-by: luka177 <lukapanio@gmail.com>
> ---
I just noticed, you should write some sort of a commit
message and make the title shorter (70 something chars
is a good length)

Konrad
