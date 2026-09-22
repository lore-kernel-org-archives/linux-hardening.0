Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157F449E145
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790110945; cv=none; b=ASqTE/KpUtjFuWaz7N8BWTd/huJboCaggdZpGCc0u36P96Sk7/eOcM1BI4tl9YGJp9t1APoJ3cV4oyAM76s8CNa0qUtChbQbpUpQTOmIOHaccfgvuKQ529vX/crkPSELyZhsjbRwQPOdTUU0jvoMj5NbQvMFQNHnmQBCqAt/PIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790110945; c=relaxed/simple;
	bh=mUiTpuXZ08jRjcCjuhENhAkI/h8z83dpTQbKz9it2Yg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=dZ7WibFe79l6J2oy4Ba+xNHp5V2p6q3WYkPgV7QugfyDnZ6KqiMfMCyQCgUW0wU599NrfcvAU+q9PPL8E/vkawY9+Ocy8BguDB0pcETkFMvIJK2mRej6SZCvArzyHcODdmVBvSRxmeOtzrfhbKsriwlNuNYGunxMQYLz+cS9Bt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b=Xz3QqWbe; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Xz3QqWbe"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe207so2654496d6.3
        for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 14:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1790110930; x=1790715730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b9Tj2oRUZivsRV4DF4owfEOUU+s6qPBlsbxiJLCQngg=;
        b=Xz3QqWbeNe6T5XRZz5L3+ChBpuAe4QPy1Y7mRbru5/87Cowhbal5ABl6u9iE2l4eQ1
         TERdKW/fX4uCs4gZiVPwynPb23FRQYsBNj4CR5aFLLDYlKY4M3Ir9uhjDfsWygU7s5Ww
         HyvmXKfYHhu+gwetWtM7Q+Kuw3YVA3QgGhHoJXqupjIUePjx7LhiGMDtPhatKgwHLBuR
         /7YOGD3GWNNj01hLOQhodylUG4ITUQ+KcNwlGjtGpdSZ+czxVMiZLdDKSOXmGQqPATQ9
         Tu59Wo3o73/oS7jmXsm8quAeT+Tbt3jir2usiSjE27Fss38BKaM8kC/77bYr4GFs4mzq
         XnDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790110930; x=1790715730;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b9Tj2oRUZivsRV4DF4owfEOUU+s6qPBlsbxiJLCQngg=;
        b=CB/XVAo6JMd0BSoB7TbsxoclloVjrxxwGS7osOzMNXzzMIxjQ8mgtG1fANi9Ln1bW/
         FlgLOl83Q21gQqrC6mqBmyaeU29UjMYdNE6s0k4fktKVhi4cpuL5bkQ9Es8C25PplygK
         wgGgx+3ICDasR17+bKrfjNHI6lbJNsMUorXfhORWdoSJL/X1D6pTAEs4j3CBRCxvM8dB
         Ngml0udwsun9/uyrQTdDR1HwVfvcfAU2fWguVB/KN7gSJAzQfCM0VzhC4AkXRa0ERqNI
         aYRALxm91LuWiiIdNRIq3gNZgg5ocLRreBUmISC9nqYNjY5Y+upK0GjTmVDGfOWuoiNA
         pn8A==
X-Forwarded-Encrypted: i=1; AKwUvByKFtVtwwCH3EnBA3xCyh8ObeVwFIrhX8N01m/aPquUhalZrTL583sX+u69w0rTt1O6SeklVkxnO3+AAff5Gn8=@vger.kernel.org
X-Gm-Message-State: AFuF++muTRnesreOK8AsfggXVoowzzxg4pexWfbhq0pQUUdaWcOa8EHo
	w7JVx69VWoQUFfE2V7iVWFB2iTBkiEHizlpEnH8KvuCmWq9a70KIZL/I0k+jY+f1ruk=
X-Gm-Gg: AYBFou0Op38cCvyvTKtQK74NqBoGpWmyDEkbY78M7YJ2VZJx/L2Y+N6S1zo7eIOb4Ui
	EEL+M2VZV+gRKmJUOYbidmF2QpLXgheWMDUnREqwNAJDC0O82pKvXm5OwhHJaMI9U/v0BI9oclS
	3ShM/0PLnKaooN2HQD0tlYkU9wGsBLfdfryslKG3ImfAm2ABDodLaVs8Cd2OYVR/7bSsKu9UJMl
	bOB05f3jlLrQaFRauvcubmOWFPh8XUtTWrqaWOWUtfCl9caVtZ1UAInUyfZgaAGkG2D4mdPJldN
	N5LwKhNfn4JkftvRsTAc6ZKbXFQvLhtJaLm2/uHKHzK3xBeKpN3lDfN5yKgVguKQjw1C+QxFH6a
	uAQ7dK0mUxRUJh/sWtAA75aRz/IYbE9qmVYfeUEBwt1wD6038PiKaMtXltfEPd1fuS1Lxil0yL6
	nZ1tvLzy0lCcAhjluRgajTG5Q/TmbUGFNUtbke8qhKYEq0W3mUkmsi2O0SJKu+/eT6yp3wGe4=
X-Received: by 2002:a05:620a:2682:b0:93c:2419:37d6 with SMTP id af79cd13be357-93c252555e7mr100858985a.66.1790110929661;
        Tue, 22 Sep 2026 14:02:09 -0700 (PDT)
Received: from [172.22.22.28] ([73.62.185.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c24822e3asm69157885a.16.2026.09.22.14.02.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 14:02:09 -0700 (PDT)
Message-ID: <7e32063f-f1a4-4259-96c9-fcbdd25c7f2f@riscstar.com>
Date: Tue, 22 Sep 2026 16:02:07 -0500
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: mfd: introduce the TC9564 config syscon
From: Alex Elder <elder@riscstar.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: sboyd@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org,
 andersson@kernel.org, konradybcio@kernel.org, abelvesa@kernel.org,
 kees@kernel.org, gustavoars@kernel.org, p.zabel@pengutronix.de,
 daniel@riscstar.com, mohd.anwar@oss.qualcomm.com,
 lorenzo.bianconi@oss.qualcomm.com, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260918165234.687224-1-elder@riscstar.com>
 <20260918165234.687224-2-elder@riscstar.com>
 <20260920-fiery-fanatic-manticore-6abf0a@quoll>
 <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
Content-Language: en-US
In-Reply-To: <85b0e7de-e4a8-4e08-b801-a9664d366e1a@riscstar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/21/26 4:46 PM, Alex Elder wrote:
>> I also have doubts that this is needed - I see no updates to the misc
>> binding, which would be referencing it. But then another point would be,
>> that you do not need separate child node, which has no properties.

Krzysztof, I've done some additional work on this based on
your feedback.

I think you are correct that there is no need to define
this as a special syscon with its own compatible string.

Instead, I can simply define a simple syscon with a label:

         tc9564_config_syscon0: syscon@0 {
                 compatible = "syscon";
                 reg = <0x0 0x2000>;
         };

And then have the devices that need to use it, refer to
its label using a phandle:

         tc9564_clock0: clock@1004 {
                 compatible = "toshiba,tc9564-clock";
                 toshiba,config-syscon = <&tc9564_config_syscon0>;
                 #clock-cells = <1>;
                 #reset-cells = <1>;
         };

         tc9564_emac0: ethernet@40000 {
                 compatible = "toshiba,tc9564-xgmac";
                 reg = <0x40000 0x8000>;
                 toshiba,config-syscon = <&tc9564_config_syscon0 0x1070>;
		. . .
	};

         tc9564_emac1: ethernet@48000 {
                 compatible = "toshiba,tc9564-xgmac";
                 reg = <0x48000 0x8000>;
                 toshiba,config-syscon = <&tc9564_config_syscon0 0x1074>;
		. . .
	};

That simplifies things a bit, and requires no devicetree binding.

If you think this is incorrect, please let me know, otherwise it
is the direction I plan to go with the next version of this
series.

Thank you again for your review.

					-Alex
