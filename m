Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD143CECC
	for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 10:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786445951; cv=pass; b=RZCF1l1okq07b2KwOqrMz/KvjIIcNLZS7+9Ka6Ble02IpM+ljsTw+wVAhjp3YQ68AoImhPiL6vRHuzJCe8CPGR0q0nLEjlKJ7kQpyWXl3vjxmC5jILKoFwReyuDPGCilp2S3Iv+0Zm+fhKUFtqLQDIB1HDbo1OFQRbtsttJ9tTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786445951; c=relaxed/simple;
	bh=0LWVUx/oODSNSqmqchqpmkWOfT9szLWKegl3rd0Uox0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzye1i++EIl73RH3IGaQUWNU4PM/Cw3CJV8lIQ1rgLfhaw59Kz9DXvGzfKKCemRph10U4gH89bhgJKrgG0/Ovk7hUii3cJkLBnL79VzG2Mt8rigCDS5m7qV6+jSpKUUr4e7MX6VoTfVra73AEgrIPXddg5VNFkTT6o1c+mUhQNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZXqvFAYw; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZXqvFAYw"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-66b13ee8801so1530875d50.1
        for <linux-hardening@vger.kernel.org>; Tue, 11 Aug 2026 03:59:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786445948; cv=none;
        d=google.com; s=arc-20260327;
        b=WI+1YU4iySP2h9SpuEsQxjeOcqUpX8KYZYEVN1a/oF8DvnwKsG/xyw6K0H/kszbtVT
         lC7o4lCK8YEfVhgjWrDySIy9+aS/agG19wTSS+6qJHqwup5hL5+/5kJocNpBIJifj3wo
         0V2gX5H+YcpSZbNt8pE8uHgglBdiwJsOJhRF+WGI/vsBRAxVJeeJQ4hXci1XMMbjmuhd
         wBLldn+Kke9xnMNRIQsUWaCM/qACXetd8nC4l16vDSIJum1OpL7SBSy/WCzOdOAvmlEd
         +rW48pcqC3xMrrKIH5n9KC9kSw0kjGoUhuuKeGCuBoIUURn3Oy5hnNu/hjDQKzWsnO7S
         QrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0LWVUx/oODSNSqmqchqpmkWOfT9szLWKegl3rd0Uox0=;
        fh=WHCNdLkfWRa6/Q38ts+aESrGpw3ko4XaytR1BPsWico=;
        b=N66/RRCVByQwENJEnkcgnBmMw5460JPayLl2vbob6bqB2tPYHLBUdIRL7A8elH9wO5
         OohdH8cyasxNPna3eyANFIwTSts9/PN/KLr90WGwb3QD4R/FNbz4LVcyoeQei8+23Si6
         Rfp/ndvGrMAGLeEEJ0C65ayZWeN74ImWDDvajzCp95H9oE1r3nQ4WFZC3RScKAzukG29
         CBtLSk5je3FZjd70Y8ABuv51d/VIaeQqfB/0toKHH1sELzn7bLV/OkI+he6vrxzpTBFK
         LVIBTUXbXZk6fNVQGA7ANJY36Dl+tiHBw15u80VAwCEH3I3NqXtjwwuijVVTmyAT+35T
         Tbqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786445948; x=1787050748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0LWVUx/oODSNSqmqchqpmkWOfT9szLWKegl3rd0Uox0=;
        b=ZXqvFAYwSLpPgJdPWBoHibKMF7L71R8nZvamHbsKsP3hnjWp7v/fO2tr6Kxl5duawX
         JDq4I5fY20U2Lx9Xczp7qYxRczXEzMaHV+XekF7AGiRpp1opKgNDw7AT6nHJEvfaysMw
         1I6SLIITpvyiW5FA6SxZ9N1qonXlJBighA/4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786445948; x=1787050748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0LWVUx/oODSNSqmqchqpmkWOfT9szLWKegl3rd0Uox0=;
        b=AMiFkJXaGyzeMJduczbOzSLpLPdpdHStBFAoBbyuN5KzBa3f5TY39KKyoqJvUn/5O8
         6qijJ6Pqqnryg/RZR6mDZpneXR+dEC86LJyTpulhc6OyX84CsJZS15XLYrkoj8wH0Xiz
         oViEoOH1YHj5/Vf71XEitPZbiX5klXwtgz7WCWZnbKE4TYQzMxo/RSZAkl/lRhMilqd1
         /26xtqTm7wTq94VAF4rZvG35fdx+I58M0Xw7zeYvWxIx6ycfZki4Rw7PvkmPUicfNS+t
         m/2re9f6CFf+uoc2ccFqksoD3ODef3eQkO2R9Asm/iwbckABlQus8dBx7JAejFqc6so7
         R53A==
X-Gm-Message-State: AOJu0YwQ1bjdHhpl33ueXBn7zzT7VW2xgwOrR3tVBwRAXPztuYMXMDLA
	Fivr2wE7uzNfodDobOEUfnVRgxS3XDxgY4C0SMs/j0GidhAWgDatOuLiLgeECOXZY8n10Y0m/0k
	PG19qyZuwcAzMHSN0IZdGlIer1dNcaOiByoukS+eN
X-Gm-Gg: AR+sD13nnrZtdjmDhm8tCD/g4Ojsrlxv2zSH5C1/6xFJqTAtYT8+gHT6v3kMqgsKPYr
	W/t4vXHjuad33VkzDK2H5Prr2KaTsL/fotMQ2gjpl01CAED3oYTvRbVrMHMDvrz0CrrCxDiP0pM
	SVurRl/FF9oEeCl2iqMhAqiPmQidCFdXiTdXJp1+ATN4tsijDa3nyvJslE6i3TJTTbj9rQIFkw7
	YIaL5IycgFdDmITYLlnXlDQLAOZDeFUR58sIjrM7mXeXy6UY1Aez1Sdrv36YToisRwBITluzHfL
	FCl+eZtXOCfu2YG+udmuo0CYrblON0nNwl1HFsLoBS1q9/49nCPiUl5fKw4tllLLXPbt2Vp3p08
	=
X-Received: by 2002:a53:df91:0:b0:669:9498:301e with SMTP id
 956f58d0204a3-66b22e4ef38mr950794d50.27.1786445947989; Tue, 11 Aug 2026
 03:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811071319.1352016-1-andriy.shevchenko@linux.intel.com>
 <CAGXv+5EKtcEy29oy=8Qah=1=PXXMds3BvR08u7DQ656FB2u95Q@mail.gmail.com> <anr_ItiTKL3pjJH-@ashevche-desk.local>
In-Reply-To: <anr_ItiTKL3pjJH-@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 11 Aug 2026 18:58:57 +0800
X-Gm-Features: AUfX_mzsUSrKmyzLy7BDEE0Nh3eOlU5S1gdGrKR-BToLFLM1Ul-1eCjnXShhIog
Message-ID: <CAGXv+5FoNEPu6kUKg7C6vgMCbmyFRbRxin=tH7o-=RQHp0jE1g@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] string: Introduce __free(kfree_const)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 6:53=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 11, 2026 at 06:42:51PM +0800, Chen-Yu Tsai wrote:
> > On Tue, Aug 11, 2026 at 3:13=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
>
> > Matches what we already have for kfree(), so
> >
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Thanks!
>
> I think you can incorporate this to (will be) your mini-series. But let's=
 hear
> from Kees and others if he is okay with the idea.

If folks can merge it for the next cycle that would be even better.
My series already has three cross-tree build dependencies...


ChenYu
