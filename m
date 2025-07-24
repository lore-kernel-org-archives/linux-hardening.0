Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F0523ABB2
	for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753394040; cv=none; b=ID0ewbcgSUdNL3fRwtPaLlgM9Gic8daFO0JPw4U5Oj2CnzNay9c8qHdCDLbvENd2SLLnS6VtkvjG4taiLRTOdfp6ZnpSC1R61Tq1OsTSuJnLYvS/XvSIQUJOefJFTmsejna6lQwcLHdogP3mj9VY6m5rN8655RVrUQfuFob/HjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753394040; c=relaxed/simple;
	bh=aSgmQpRl1EtsgTtoq5gJuvcK+lbZhF6aqiMeD4bLeyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XkiKeSAoqN0MaYLUevImy1tBzU1QHSM6MQc0ly2LIUz+q7qD8VzW0Kc2vRQZbKE9t8J6MhcHO7UPmKSRtV+kvK5anKcc/JEZ2oFyb1fxnZybz4ntblLzdvLoGgdjBR2+jyzM46ULiShgQOZOapnlEk8QPXiWslGYJs0HIvgQmb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OpycNFQZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpycNFQZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753394037;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jXLN4SsCK0ZOlY5y21K92auQYthqaAwqTZRZM+NRLdw=;
	b=OpycNFQZ/xYgtwXd3kiZj2QX/LXIflzLWzSfsF1q37p2OKEfEYPe1G4jzPYqwHhRGfniTH
	wJvXrb85rnwpLK5miRTdWnguZl8naRinOPk4462wHzO1e8M7gVTPwZ/JRKFkpv6HVHWTIy
	mDG780KQamiPvH/aVS4TnSfkU1XQCB0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-6Wsch-L4MuOwH3AfQRVGJQ-1; Thu, 24 Jul 2025 17:53:56 -0400
X-MC-Unique: 6Wsch-L4MuOwH3AfQRVGJQ-1
X-Mimecast-MFC-AGG-ID: 6Wsch-L4MuOwH3AfQRVGJQ_1753394035
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a6d1394b07so849520f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 24 Jul 2025 14:53:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753394035; x=1753998835;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jXLN4SsCK0ZOlY5y21K92auQYthqaAwqTZRZM+NRLdw=;
        b=Bf7rbPC/dPqjxISUrrpbLJZtT1L8UZfsLpND88mOhyqqMvB67vm6RQbGMP4XndrElP
         Xi/8K+RYiwbaT0zfM1XSN8B5unuDzRMGsBR0gdaP6iNLJW0kJboMqu33idwPmLsd4cFh
         b13AHohwCJ1zREToRvKw/N5KK1zKlijyYbJu4XfEehRjmdO/uOa3HmEo840RnL+BcnIa
         HOp7Sf3xDJ88H+BDwJpxaCO4zQXC+lzrsiBFQuYwfKoj+10XNUUQarfA+8mNoNBl6ckF
         HUHrmWFeIKtwC6ke6H45uswFjfJoq8fDzG/2eHzjFUIEmNvMPcEw6rya3+cvgS4xaxOF
         vhgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVm492quyt3xipYpgzNvgyK3qKtd6ynYsEdOSCrvcQ7fTPZxQf+KLERCWyFmgYtqlPjqSM5q0fqiwjX7uaejBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1XJuO1og/MmuRosGzq4opBFiAbMdTsK/9nKlJeiLDk4Dh6XD+
	reInUYS74rd3DLw/jZ9zU3OoodZA0VSWX0Iu8vzaWN9+Bvys/mzp+GziJ6Wpb7vRJf28d2es4o1
	SR3zwVzp9kvl/zPvlePTVsoplQWud1rHk5C+w0EAK8USpcA0yk40Pz/tXUx6nn31EmIt3zQ==
X-Gm-Gg: ASbGnctqQq5lKZF/JkgtzF+RHvpiaEpihp8vJzf9QjHYMnoD+rDM4C0pDSGJEJKK/qP
	U2s5wzW1VsWdyG3m7kvciNB8YgWKLLumg12tljxqQDZgiJ2t6IqMO4d/ycF5tFvr5OVj19N0h6k
	AsHTFj5REieoF0r5hTqJ8ulDi5I/TCx9z5RLaj8K/Hex7vPmKn/5ol4oos5SNRWEvL0r6nZg+zs
	QVLYFVJHPPPkUWWj/ZHe0mfB+HPtog8GBwVlaSR747PSDBB/BnjI+xEC8X1d+KoDev7ptCdXO9w
	MZ8LkJkZzTy2h6Ig3J244xJGMeMQ3/ejN6e0yakRKF7E5kRzK8Zm4HZE70wsMDvTzVFD12hnj+T
	djlAgO8YPZ3IKgX5SeHnP7vrEBzLOtqkc8CqcDqL0vk26z2VcyF0aoJWv8vNwo2Ht4ds=
X-Received: by 2002:a05:6000:1ace:b0:3a5:2949:6c38 with SMTP id ffacd0b85a97d-3b768f14a6fmr6764500f8f.52.1753394034748;
        Thu, 24 Jul 2025 14:53:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkJOWTq8/VD4bvUr6a2rEovzwLN5dTrmxK2FT42yxexbPhNZb6gZWZXp4oLGU60o1OpU2tGg==
X-Received: by 2002:a05:6000:1ace:b0:3a5:2949:6c38 with SMTP id ffacd0b85a97d-3b768f14a6fmr6764479f8f.52.1753394034223;
        Thu, 24 Jul 2025 14:53:54 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f01:5500:ba83:3fd7:6836:62f6? (p200300d82f015500ba833fd7683662f6.dip0.t-ipconnect.de. [2003:d8:2f01:5500:ba83:3fd7:6836:62f6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcc3ccasm3300445f8f.80.2025.07.24.14.53.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 14:53:53 -0700 (PDT)
Message-ID: <9c861191-ac9e-4d26-b2a2-1facfa45de44@redhat.com>
Date: Thu, 24 Jul 2025 23:53:52 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] mm/mseal: update madvise() logic
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
 linux-hardening@vger.kernel.org
References: <cover.1752687069.git.lorenzo.stoakes@oracle.com>
 <ec480dc1fd4ce04bb11c0acac6c6da78dc6f4156.1752687069.git.lorenzo.stoakes@oracle.com>
 <CABi2SkU75e7tXcpgnLbDhqSJBWVPOvmfMh2uPsU3mUjMUhhYqw@mail.gmail.com>
 <38ed372a-4b27-498e-bb3b-f95792bbbe27@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <38ed372a-4b27-498e-bb3b-f95792bbbe27@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BBC-Ei9js0tXzwA8NlHaTKvVsKgDzKWSNsACnNsA87w_1753394035
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
>> 4. We could ask applications to switch to non-destructive madvise,
>> like MADV_COLD or MADV_PAGEOUT. Or, another option is that we could
>> switch the kernel to use non-destructive madvise implicitly for
>> destructive madvise in suitable situations.
> 
> Umm what? I don't understand your point.
> 
>> 5. We could investigate more based on vma->anon_vma
> 
> I have no idea what you mean by this. I am an rmap maintainer and have
> worked extensively with anon_vma, what's the point exactly?

I think, the idea would be to add an additional anon_vma check: so if 
you have a MAP_PRIVATE file mapping, you could still allow for 
MADV_DONTNEED if you are sure that there are no anon folios in there.

If there is an anon_vma, the only way to find out is actually looking at 
the page tables.

To be completely precise, one would have to enlighten the zap logic to 
refuse to zap if there is any anon folio there, and bail out.

-- 
Cheers,

David / dhildenb

