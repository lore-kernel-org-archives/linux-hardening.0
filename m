Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81B25F7A9
	for <linux-hardening@vger.kernel.org>; Thu, 12 Mar 2026 00:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773274664; cv=none; b=cL7LkvpbgMAZVSo3pvWGZUJUzvOFRxmmpQnocHabE8jzEtHqjKZ3TOo84Uz68dX2Xvod2Qm3ymwIwR+a9SExwFoJ2OlbIlz722l2r24ysAYHztrppsZcUDnw6HeXvJ/8NvlAHYSZyW9WLy6uysCrY9GjR1THXPck8g5m+ZQ410s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773274664; c=relaxed/simple;
	bh=J94a3IVEEaoMRkqxtepLhVXeDfAETLbtAimu3IcKwao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kn+5AClaQ2fHHLAGJer3E8x13eFuJkG3H0om5IIcVGtF4h8ZOSEQEWQOwh839hp7uF5fG9X6d3rpAbV2+zU+p/7qgcabOjCGKOr3jROK8gqBz4hbNVahNKIQgIaMtDYQBwYvKWxbaGQKc+9rKUiBSi8uDG16nnQX3UoW1hfnd+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EEUll6qn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEUll6qn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-482f454be5bso16454685e9.0
        for <linux-hardening@vger.kernel.org>; Wed, 11 Mar 2026 17:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773274661; x=1773879461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J94a3IVEEaoMRkqxtepLhVXeDfAETLbtAimu3IcKwao=;
        b=EEUll6qnRhXRvHboDT7438D1ahG/icnE6WDT/dx2SQUIWgCMZtlNZlFFxsvvaNxyCp
         5KCnWAv4QEEtF6ECCPhZZpu29zNNY6XQVnmGManbcaFZAdeRz/gHISFaNfWfAz3PKxmC
         d2Ae2mWuQ1x4basbClz/uzWjS838Zc6qjeG/boqSlMw1xZaJNcIpsJmilVxlJUYMr73W
         fHZIi3j7jea0EiLUV6erzCxDyq9ZsaJWa0C2SnV9LnzYK/HzvoRbGazj2yiaoshuYnAw
         8PXoenzBNA1ebuW90dC3cMupyKAEePyeVu1ritYofuxk5a9pfQJpecJHZd9sQB/lphui
         ZfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773274661; x=1773879461;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J94a3IVEEaoMRkqxtepLhVXeDfAETLbtAimu3IcKwao=;
        b=psW8DT/q4oF6cPfq6alnZWeoaZu6awMiEpS7sLqOmtKPyFkGS6LSUO+e+G6bDRbGrl
         PDWjrygejPyIl/FqSzYdxWBvxfoZQk7sDuQCk0dvB5BPtwiSJu68vDJkJg8+aBhJHlsD
         f/sZ3E6aC3jgCJGMRrSAIuldXxqQj/FM24XRQMGEXVUbSP/Aat0gSvTSa6KiGv1SZPey
         ZtJr+5Nl/3+fwvJ/3aG71vpT/MUB/x4eyK2lQXWYTU/KBzwiOYvyD7lxTGmXq9Uo9MRe
         7BO0e/icmAejUy7NEFdDxhN6wzBqC+Z7f9pyyaX0z4uksUJPtDFvtakxcdUKdpCTBLTh
         3Flw==
X-Forwarded-Encrypted: i=1; AJvYcCVyLzvEyaUtYJGICf9CW1/wtzWVuNnVOK+LPu+9ZDWdexblnckpNCSxKQdDZT7KJosOsEiCp626kcD7qXlGLOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mfKBIEgtMAlFxC/sj5eR6TAemauPPTSS2evIJDBB5XFEfwLU
	kgJFtosT4Hv1jrmhEEMMR93Zj2ZJytthON8DhEXJGD4Q/Slp/WVrIrI/V478gzSgX38=
X-Gm-Gg: ATEYQzzTPvxEn+1WHR76XmVTEgbEYjjXFp42bDM6a6NHuLZNNIV2LUedcpIzAVYwO5X
	aSI8vbFAJJ6AUh5bD9Bc0Qr4aMQtotcSABAsBBSUMpyG5+0gX74ZdR0ifI3bC6cgC75yGEtFY1a
	JAAz+8Suhvvky/n5pNydY/wYYwtLlMHtwEi6JADqdqh4378GJDXCZ1DZ4sVDLh8WvfTjtB86yXq
	Fy3Pf52LJdIh1SVy92RhJFSYbYN+WSc9rfAfl/VZRh1jp/yYnYiqO6tg5CKWV6WqDeJ/3J4xAXy
	WlUqc92usAlwyvjHr9cBZCBGN6+K5h9EFTf5prsQ2Az/Huw8z9knuRnDiqygy7atRbimCQdRwWm
	Qf8AFbu4oZrWvsBIQJbzuphOI8fdgiSu78bJAhsW8ahPHedfMg8SvZjPIMPihJyvcoSiJIsC2cr
	sMqD0750//uqZkgw08qDoZHc6ePFXj5lCbzA==
X-Received: by 2002:a05:600c:4fd5:b0:485:3989:b3e4 with SMTP id 5b1f17b1804b1-4854f578e86mr24296235e9.6.1773274661166;
        Wed, 11 Mar 2026 17:17:41 -0700 (PDT)
Received: from [192.168.0.101] ([109.77.88.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm86375075e9.3.2026.03.11.17.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2026 17:17:40 -0700 (PDT)
Message-ID: <2d0505f7-a9de-4276-9422-0f9d60cc3e62@linaro.org>
Date: Thu, 12 Mar 2026 00:17:39 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] usb: typec: qcom-pmic-typec: simplify allocation
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-usb@vger.kernel.org,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 "open list:QUALCOMM TYPEC PORT MANAGER DRIVER"
 <linux-arm-msm@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 open "list:KERNEL" HARDENING "(not" covered by other
 "areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
References: <20260311232347.18257-1-rosenp@gmail.com>
 <223e0295-1819-4234-90d9-7db440f25be3@linaro.org>
 <CAKxU2N8_ZsHR9Uzpw=XbnsFiBoY=ai7AZ2_LbEw72ouCVwKb7w@mail.gmail.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <CAKxU2N8_ZsHR9Uzpw=XbnsFiBoY=ai7AZ2_LbEw72ouCVwKb7w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/03/2026 00:12, Rosen Penev wrote:
>> Patch count bragging rights !
> That's just pointless churn.

Obviously the most important part of all.

In all seriousness though, just break it up a bit plz/ty.

---
bod
