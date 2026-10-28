Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793215415;
	b=iJPm2JTP3hnP769rIyTrfFyWBGNvcyQtJJQBeHAWPYCOx9ODM6unnMrIRRn23HKUW7GZ
	 cDJErLYViySfUMHlWvJ4QlG6z3XTKqJ/HFzFpBhj5PioMLxDhNJEvSS+NbFMfReqFIJwT
	 5C8HMiXjHspmjU69ukzKF9AsAycY091z5zyYqIo3QA3Q1RVTW+L7Sh/rdAz3m2hMfd8bg
	 B4GKkFYADvNIdzkKhCCZQoF20xhBRskZgm5VbSCrEj2JI6DSW9eONk/hn/x3ynYwCq3D0
	 r79678bTaDWwty93ANGcuzcA6V/Vmq182PLEdq94OXbZHM1se45UybvjfwZjOK4hoyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793215415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BXrl2Gy2EHaylNKL4MTPyKATt4jFZLfoVq5Oc32xJ+0=;
	b=nORnZEgaUFbU+jIL7vOkA4mi5qTx8plBenA9HW5EIs0laHPM7Q5+xK0+fiZYlRaEWFSu
	 uCSdIixkebWgQXw1KUTCBVpexgmuDCDrUHP7r85DyU6kZgjxD/RMIH48aQMpXnAKqcFmR
	 LHtpg8/9kab3I5CVSO8EtpD5C8QByG2IeV0YOu3DSHzqGN1rK7tIQ40GL2NXuP9SXMj5D
	 3Xc7KfDh6paLMFMUDzGsxyIaUVse+e8K2/ozRNrZFQYEhlPX1sfA64DyHJWs9eoGhLLlC
	 CB6S6VjG58eo5dz0DVTDZCqGW53wiEcJCgRua4pZ9udEc8PKWQUaEQ4gSPX5vemfyQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jgt6xSuZ;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712BE606A31E
	for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 19:23:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 712BE606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jgt6xSuZ
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48e0d1c095dso730321f8f.1
        for <linux-hardening@vger.kernel.org>; Wed, 28 Oct 2026 12:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793215414; x=1793820214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BXrl2Gy2EHaylNKL4MTPyKATt4jFZLfoVq5Oc32xJ+0=;
        b=Jgt6xSuZrNU1xu7yuq7GzRE5SO0KShBkCtOAREqPjIqnXhax7gZ9YLCxDeN28CBHI8
         a6e8prcVd6zz+Qh0YCVoTZTe/JkyW2umDzI0cGa+FO3kY57EwskwHrzVCp2tDvLD0PEp
         W+Tg4zsvPdGL3b+gImuFkxMvm4t8OGHy8g1QkFhK3dMr38z+vvRGKFe4iO1WIRh+STA9
         Q3pDnyl0zEx55QH2w2B7fs45IP2o4wLSSBbJaqRZgmWLsh1rwlE8JPVYKov52D1O2mnM
         x0BgHeiaS6tdR9rdHOn1ljVvQ00Dmq+gPDxIZZ0p5C3VlWNHbeyrKRXP0TJKmLtaw4OR
         P/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793215414; x=1793820214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BXrl2Gy2EHaylNKL4MTPyKATt4jFZLfoVq5Oc32xJ+0=;
        b=ugY7Ekoqw+QhfMl5W/TCxUIkyM4igjHKWgGCh65lSz/JLkTI+brSQzTdxY7UJa/ZEY
         O5/QovcyUpJyUtZMrjXS1Yg7peMM5+imcfQBDF3Rh6crkq6GUleTJJGe0H+FclrgAvP6
         o/3RYPGJq/ojfBlXxUMjLOq1dZqALJbsaY4JJImKfTbPrEbNF7W1nYafJeLkih69/p5O
         wBF+fl4k4QJ20mZ91aGmH1OcG0DurZ0YpHnrKqmHcYsYtJPpzR5C5EYxnCtAqELXa4t9
         7LXEL6/W4qadnIX6fR+VziJgkGcHZQyQ1/wHigGOKeb9DY/2KAwNCF0eUT2kgFK6DkeI
         ZNiA==
X-Forwarded-Encrypted: i=1; AKwUvBxbnRJzgzfL4EXldDKxwESMHmUs0e3BFhQijDvhPIBS1tlUahEP0YddkqPyZHR0nC6zkdxcrIQ5QaWlAgJYCvw=@vger.kernel.org
X-Gm-Message-State: AFq9FYI81JDUaE3q7D4oBogq55E9hf3CXFPl9jBoDw90Sqi/S2KlyF2h
	esrmWFoeiGTgpmm76qZGzr4ytW8lcXpzNS9JdcGgBMkKhUnzLpM/S9iV
X-Gm-Gg: AYBFou2v1a2OgVttBCdu3lmP/jMluA2y8TiDT+dkt0YVWMid/0ueUBnZmZWXyrp3YWs
	canmu89HYnDEMWwxK+v9fpn3+lgVJLcWZYdXrf0AHRi3GAYh3phjFEXZoDlMvcQs0TnFpbE8Utm
	cfaaP9ASZHuUR0ynNlHw9VCq1GgK29pCQQYvJFEfKIReMuofQ8r8tzah3H2XWm7vJi3JYvfYvjB
	oucbq35uIcSXNHxQPjhMEjrOLjKgIDuoZTdykA1PPMYNIi86t4P5MM8Vsjf7xMi4lNQl+TScRO2
	eqX4pz9wtHe3I21JfIJsvTMiskET6Gc42JTpJIb/sr8PWtIyxuFVu572q+HEBSXMaZ3lygUO/73
	BfL7rm2BzkGcDXQy/0tNLq+4NI9cZIVUFcoeCZtViXE+/50gwI8UQil3O1GTOtd6coFGLggKZso
	x5EjRan1DKLJ8jjrphelxhM9cKMpIyflg5Vp3bK0n/jozOAU5MopNQ6vopnA1j+DmZ1mAJnncmk
	TjZ/Z+QAFUi0AKFgeXhy1Z31Ox2mr4W/4B9eTNKu97B82gUJJAczL1ggCI3jpxzGL6ADYAtnTJZ
	VfVMyDepLBtf60AsGm4c3pG+VvxD/Q==
X-Received: by 2002:a05:6000:46c3:b0:48e:62a9:1a65 with SMTP id ffacd0b85a97d-48e62a91a6dmr2250254f8f.49.1793215413691;
        Wed, 28 Oct 2026 12:23:33 -0700 (PDT)
Received: from thinkpad ([2a00:1370:81ac:50e7:d3c8:c903:5898:874a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecdd5b3sm29978125f8f.53.2026.10.28.12.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 12:23:33 -0700 (PDT)
From: s1nkhole <dedemorow@gmail.com>
To: dave.hansen@intel.com
Cc: x86@kernel.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	hpa@zytor.com,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <kees@kernel.org>,
	Brian Gerst <brgerst@gmail.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrey Zakharov <dedemorow@gmail.com>
Subject: Re: [PATCH] x86/entry/32: Harden return-to-user
Date: Wed, 28 Oct 2026 22:21:39 +0300
Message-ID: <20261028192139.32606-1-dedemorow@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <ac147f25-a2d3-46b9-89c5-44a1c0e4f038@intel.com>
References: <ac147f25-a2d3-46b9-89c5-44a1c0e4f038@intel.com>
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

From: Andrey Zakharov <dedemorow@gmail.com>

On 10/27/26 15:01, Dave Hansen wrote:
> I'm curious who cares.
>
> Is anyone who is actually still running a 32-bit kernel concerned about
> this kind of hardening?
>
> If no one cares, then I'd rather pass on the complexity, even four
> instructions of it.

I don't know of anyone. The only motivation was KSPP issue #41, which
asks for parity with the x86-64 check added by 1e4d3001f59f, and that
issue is marked as low priority because 32-bit is legacy. I have no
report from a 32-bit user asking for it.

Please drop the patch. Thanks for looking at it.

If you have a moment: this is my first work on arch/x86, and I would like
to contribute something that is actually useful. Is there a small task
in x86/entry or in kernel hardening that you would suggest as a better
starting point, or a place where help with testing or review would be
welcome? I can build and run kernels under QEMU.

Thanks,
Andrey Zakharov
