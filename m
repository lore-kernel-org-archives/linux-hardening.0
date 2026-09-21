Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DE4492E4D
	for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 11:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991720; cv=none; b=XN1OmDqveiOhoz/nz8c4be7EAReX6KyInDFMzIeSA1AcbHuBZdJqYSPGPRT3ZJ8ZaVzcxK0/StcB6uDnGYcNMix50UbdfwWcYuTmPHHi6rzRTWJO8B8vFoYT+hSvB6q5WZFIt/ZnZhdfkOY8q/SCa+HO/vG8fNMbfbYsP8xTIFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991720; c=relaxed/simple;
	bh=w0043UFoabFN1idwysUYX/vETTsf1aFbar1G7lykZx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CcRk7i3b3Rc5OAsplozOQjj8R+PUMD51qet1kDoS0NTHBHqz9+YiTUb5hkgL3ONlBYhHgpixlpF5LDSLbcLhxIc/3pBvsb24bUg/HJtgcstB29uWFJLwluX6EHDbWSM0EssWvhq9pfFnvgFL/koBeYHvf9M65SVI2t6Lj3YMs+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WS6Ei1L+; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WS6Ei1L+"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd38e0e5dso40064385e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 21 Sep 2026 04:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789991716; x=1790596516; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KoGx0ZyZW8wnp5QELsj35eexSkwzaTvnMBYC7KfLg74=;
        b=WS6Ei1L+793kk57RUzfW66Aj+uKd7LjiOa/s8f7lCLlksQFesVCwYsKg7gbz9PoNVJ
         ksfQ9E4goZ+9nuf0jh91rIP+Wm5HxApPQ875ru6cOwt7tYJqy3ZbIohmmJgxU2YFqvZf
         AJDlXMcICsbCoP28puiRVm5Pm54ufLAf221v9kxc8xQvHCqCGfDX1eopwycQ5L46fHrt
         j+8KTILdtJOrY2hijT9UHkeWFZg8OUxFYatZlZEGU0/Wf/Cst8aw1RYsLw5kegkWipDg
         6RrqI3CBQ2ncjAz5vuLhT3sE5+gzwI2Q52O86G8dxXsu0cd5WCd/cBTdb9BHGA83UWh4
         430g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991716; x=1790596516;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoGx0ZyZW8wnp5QELsj35eexSkwzaTvnMBYC7KfLg74=;
        b=sg7xC/iAYo4pXGzZnAfm8BRFWeo6dDiR/DS8zBJHuTSanD8BRNrLbgs8f4VDMtHbwI
         A9S6Cp+e5gVcbo32iY+yXi+n0AjLd2Jsra2BJ7CA+MIw9KN3Hg6VW8/RUrDAK7YavTdQ
         Yp3ZVQG0FogaCgBokPuEMwMwRYNFhJjzVhe1hqlSVsf6t0yW8ExPGul/AAB7E6xXJ56w
         nS65R6+cSyWvM3ZItJl6HwImqxWrvZ0Wv42v262ir+hidYQfVaYI4ZaK/HdaAAbgYEro
         HscKV7SjbnbN2Hr7xopmuBzwqM6B9xyahHE4V9gTOWwtrQs19uB+rgJDY2gw1a3XBhLQ
         hEjw==
X-Forwarded-Encrypted: i=1; AKwUvBz1MEb3L+/5YIOa9xF2SSPx4eO8dyqe04vol7uAVHe2QBBhYD/kCYf0t+87NWTcgF+djzTG9OIh2roLvlbIHmI=@vger.kernel.org
X-Gm-Message-State: AFuF++ldnq79T1XJ3AEaXFNC2Me6+hsdO6VckJL1jfIsu4UH+226PpU2
	uBkfjMQqi8IfAEngadhGcy1D3yuq2sKD9nfloV0Npp87G4j6Jextf1VWyAGOXW2BW/M=
X-Gm-Gg: AYBFou1ylhMUFNeUOFh7C7EExkuduB8JMTdI+AK4i8BoqXjaVkp+1GTLKmfxTr/qVN3
	/FrsF8tp+v/6AOlepcOPh9ed+AkM7+PfWRKajYgsGOAKL1+/DfJXo5sq/734c7D5yO91qRvgwX6
	HhJ5szLFx3kRL6Dn1kj3Q4PwtwOC72lh+KL/uE25cCjZKAVFBYSRkuzi4/GE99z7d+s68pmqCZ3
	c9FWCjxYv95NNiPKwAyahsIDGhbj5MkSqpJ7Zrsv3C37ZqLjWMSqTWKvsropHRDSAFOmogpGY+6
	w0EJhijqJXq3O4jFbB/Ggp14ZbN4QGZXLRbG3S/jgVPvFo9beGKdhrZfhO6vXoV4+1uElKQYoku
	oXtDcUOSyGnZpyXMexPAygkC07Zt2bmhwx4q6blG0Ej7qM1xbdf6BNZqzvyHjHiIMU8pKmgct3O
	07oEn7JZediaoyCFAmwApIUPknMFpbkbiwnxn+QteGD5uq/4X/5P5+dc0MijQi9DTfAvgkA4PsN
	3sdzqGx1lerXPRfzggaddjqDwl6KBq4VyEWuZn4CIbtXw==
X-Received: by 2002:a05:600c:4e4c:b0:49f:bd3c:bc28 with SMTP id 5b1f17b1804b1-49fc574f456mr149078405e9.35.1789991715929;
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd0eab91sm244798625e9.1.2026.09.21.04.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Message-ID: <d771ad48-9f75-4ca7-84c9-04139afbb7d4@suse.com>
Date: Mon, 21 Sep 2026 13:55:15 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] modules/kmod: Allocate argv with kmalloc_array()
To: Kees Cook <kees@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook
 <kees+treewide@kernel.org>, Daniel Gomez <da.gomez@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20260917211229.i.604-kees@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20260917211229.i.604-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/17/26 11:12 PM, Kees Cook wrote:
> From: Kees Cook <kees+treewide@kernel.org>
> 
> In preparation for converting the kmalloc family of allocators to the
> type-aware kmalloc_obj family, we need to make sure that the returned
> type from the allocation matches the type of the variable being
> assigned. (The kmalloc family returns "void *", which can be implicitly
> cast to any pointer type.)
> 
> argv holds 5 pointers, but the size was taken from the array type
> "char *[5]", which would make the allocation type a pointer to that
> array rather than the "char **" being assigned. Allocate 5 entries of
> the target's type instead. The resulting allocation size is the same.
> 
> Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
> kernel/module/kmod.o
> 
> Assisted-by: LLM coccinelle
> Signed-off-by: Kees Cook <kees+treewide@kernel.org>

Looks ok to me. I've queued the patch on modules-next for 7.4-rc1.

-- 
Thanks,
Petr
