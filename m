Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556C1B422A
	for <linux-hardening@vger.kernel.org>; Thu, 20 Mar 2025 06:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742450622; cv=none; b=fapuXs6GlmrRc2tSP5ZkWYem9WF8skd9S6XFBbgGfutfJQQ52dQHz+/mJuXNeOEqCA0t4Zn9GwY4iG4SN47KKNNEK2PQoxI5pW+o8kq4lxvjLiQv//0d5AynqcdAc43iToESsTfEm8RL0fTVsZg7iXiS3bj0zsKoZXEXuXcVFDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742450622; c=relaxed/simple;
	bh=oBycr6yoTR/XQt9L743N6Lo8JRUTc8DPHmcT1O2rPO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BuK+WVd16nupLGbYOJxEVoN3q4tpqlXyTu6u6bqGTkryYwhFKs5oe5gfW196jHEwvUCSP94V06ZPYKqi35oYKUVRlaMV/SE3XQznAluPvxhjdUu18z1kLMuEYPd3ziBnLqHzbTAwRznJm798iAe+MkSGFNr8x0RognerekiDuTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com; spf=pass smtp.mailfrom=daynix.com; dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b=W5ezF0t3; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=daynix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20230601.gappssmtp.com header.i=@daynix-com.20230601.gappssmtp.com header.b="W5ezF0t3"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2255003f4c6so5217805ad.0
        for <linux-hardening@vger.kernel.org>; Wed, 19 Mar 2025 23:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1742450620; x=1743055420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EUlQy+omekyAlQ/UT0+jDTx9lfmxYWK64YNT4WpuUK4=;
        b=W5ezF0t3yXUaQx7LeiVZS+sVU0dAcO3LcOcC9R55zaAGQqNGZrhN3baAGeER9qr+lO
         7hU0Af/WDVvTwH03PhXpNHkQcW1KA2+QovelRnfz+VZCQgafhUS+bUZzEAW/9vJF5vO1
         1VocisXxV7MjxmoEMO7o6Xh78zfoZdAy4Vy+x8pfYrGHHLGHpU+sNfXT9fBrdIqjB5pN
         U1JX0fMxkFlhSFHrHjKi9FUWq7ReTSazdamHJWOYF23tw7OeCep/VuSMINE/LbXQsrbV
         2qSZyagslvEHqQV2uSRhIQsbiwyzXtVo469EUkOo0fHRG3FUa/bLgWzUSuJ+Mlz3rQAg
         w3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742450620; x=1743055420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EUlQy+omekyAlQ/UT0+jDTx9lfmxYWK64YNT4WpuUK4=;
        b=b0kBztLmSIJes1csOpibK/RVqP+nz7zh+RCwJjmCfiZ6GlHIeCj65grKXIR1GXaN6m
         cY9ZgB/4xSOvusIHcJ//41CynmP2E+QN7l8D7VnC2EceIFRRDIVudRmyNt0yAyKl116b
         Czi6Cw8dlhhEJKE/hL8PZxOwyOP2za/kGAQiV49Kf/8F35gcZ+IAMo+mV7FlLya1PpF1
         +HoGNr0KI6iWgFoVPVD0LOBVMoOncA7Gk7CzJPLiUD70Tr49u+DKgyHJkU7X/VRTjkTN
         CdJEJP++Moe1uZ+qKkSiCQ/kA5cSVp5oJza77+94Z6NY/RcHs3a5EKE6in6ttaMKkVa7
         e2ng==
X-Forwarded-Encrypted: i=1; AJvYcCXbT4Etey3NAxpnH8FhGCgxWJ+XnBc0xgYrDVc6Vj4O/m272yRS2lmf+Dk0ApbwJlAQKwxYMzQUF0GCm0Z4y9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YypA0myVEsBmAzz37l5cwAFQromj2JVL6DnAsNS5kjBb/1OGy1Z
	PqktlSduuxU4Lwl0VmkzknmV8+I5KziQKz+R9SR/BpmYzUfF8qHLV25HfFG1+Wg=
X-Gm-Gg: ASbGncsS5bpJchER5WR5m6AinomxZDB4NfuvzEf8SZJkbOE5+YBkdGKxdyaKyUWRcmH
	4hyZ+9UwYZk+rI1f88K+3Ec9dBeqdo0B2o7nwrEL3Zch78XH9XRlwduYnOcpcN6fvaGOHniSd/v
	4Cz6OfnyZv6rgs0UwIzaeORGVBlALvxwwKUthD/dwcPxTHKAAP+S9F8ca8JXZGFf+vOZLE2iczC
	MLxV+79xaZhe1XgnecpJae6GWEuOx+jlPdFCKmejt1wR/0EB2S1VBTr7M8PJCtBWjXv0T+/HagH
	sPNDKdrnSDoXvn1/YGoUWQT9pXOZLa6kUSxYiAvYPR3wacoUC2SsgxZZ2Q==
X-Google-Smtp-Source: AGHT+IFenEJO6TI9Hsl5cc1hX2SStJer0wmUMMpctF1K7VqnKKB8w0l0InlYXp+IwtSylHw5lHcLYg==
X-Received: by 2002:a17:902:d2cc:b0:224:1c41:a4c0 with SMTP id d9443c01a7336-2264981b59bmr83265325ad.9.1742450620129;
        Wed, 19 Mar 2025 23:03:40 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711557e9fsm13269592b3a.51.2025.03.19.23.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Mar 2025 23:03:39 -0700 (PDT)
Message-ID: <0d84bc94-1c65-4737-a2eb-aa7f96a7d1e0@daynix.com>
Date: Thu, 20 Mar 2025 15:03:35 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] KVM: arm64: PMU: Use multiple host PMUs
To: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>
Cc: Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose
 <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 devel@daynix.com
References: <20250319-hybrid-v1-1-4d1ada10e705@daynix.com>
 <Z9pze3J2_zrTk_yC@linux.dev>
 <e8324d9d-3756-41cf-a102-28572e302368@daynix.com>
 <86plidmjwh.wl-maz@kernel.org>
 <bd681ec6-0b4c-47d9-8a4a-b7324c0883a6@daynix.com>
 <86o6xxmg87.wl-maz@kernel.org>
 <aabd71eb-286b-475c-a30e-d5cf5c4f2769@daynix.com>
 <86msdhmemw.wl-maz@kernel.org>
 <cd7b4528-34a3-4d87-9711-acc2c2e6f6e1@daynix.com>
 <86ldt0n9w1.wl-maz@kernel.org> <Z9sSMJAlf7cQ5viu@linux.dev>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z9sSMJAlf7cQ5viu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025/03/20 3:51, Oliver Upton wrote:
> On Wed, Mar 19, 2025 at 06:38:38PM +0000, Marc Zyngier wrote:
>> On Wed, 19 Mar 2025 11:51:21 +0000, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>> What about setting the flag automatically when a user fails to pin
>>> vCPUs to CPUs that are covered by one PMU? There would be no change if
>>> a user correctly pins vCPUs as it is. Otherwise, they will see a
>>> correct feature set advertised to the guest and the cycle counter
>>> working.
>>
>> How do you know that the affinity is "correct"? VCPU affinity can be
>> changed at any time. I, for one, do not want my VMs to change
>> behaviour because I let the vcpus bounce around as the scheduler sees
>> fit.

Checking the affinity when picking the default PMU; the vCPU affinity is 
the only thing that rules the choice of the default PMU even now.

Perhaps we may model the API as follows: introduce another "composite" 
PMU that works on any core but only exposes the cycle counter. Robust 
VMMs will choose it or one of hardware PMUs with 
KVM_ARM_VCPU_PMU_V3_SET_PMU. KVM will choose the default PMU according 
to the vCPU affinity at the point of KVM_ARM_VCPU_INIT otherwise. If the 
affinity is covered by one hardware PMU, that PMU will be chosen as the 
default. The "composite" PMU will be the default otherwise.

Regards,
Akihiko Odaki

>>
>> Honestly, this is not a can of worm I want to open. We already have a
>> pretty terrible userspace API for the PMU, let's not add to the
>> confusion. *If* we are going down the road of presenting a dumbed-down
>> PMU to the guest, it has to be an explicit buy-in from userspace.
> 
> I also have a very strong distaste for the crappy UAPI we have around a
> 'default' PMU. At the same time I do recognize this hurts practical
> usecases since some VMMs can't be bothered to configure the vPMU / vCPU
> pinning correctly.
> 
> I'm at least willing to plug my nose and do the following:
> 
>   1) When the VMM does not specify a vPMU type:
> 
>     - We continue to present the 'default' PMU (including event counters)
>       to the VM
> 
>     - KVM ensures that the fixed CPU cycle counter works on any PMUv3
>       implementation in the system, even if it is different from the
>       default
> 
>     - Otherwise, event counters will only count on the default
>       implementation and will not count on different PMUs
> 
>   2) Implement your suggestion of a UAPI where the VMM can select a PMU
>      that only has the CPU cycle counter and works on any PMUv3
>      implementation.
> 
> Either way KVM will need to have some special case handling of the fixed
> CPU cycle counter. That'd allow users to actually run Windows *now* and
> provide a clear mechanism for userspace to present a less-broken vPMU if
> it cares.
> 
> Thanks,
> Oliver

