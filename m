Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E374123E
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d170GTQc"
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE84112
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 11:27:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c54c8934abso7555041fa.0
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 11:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697653667; x=1698258467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4LSW7ZRKgP1lLxQuTMsxLUqNOunePLnj/+UPZS75Rc0=;
        b=d170GTQchcgh4eFQs3SbuuiSVJpu46qk5ZSDAzpENKcj8Lxroui3MsC3mVJEextjlI
         Lqz88nGvWXSmflaMmApRl6rLHz8V7jr1nnxgVW+OtxOpa7ubyNHGXSrJe3kTgZpKYyrL
         6n40wtIvMPI7CUiKqQK0FW9c2i9o+lg8Q4QEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697653667; x=1698258467;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4LSW7ZRKgP1lLxQuTMsxLUqNOunePLnj/+UPZS75Rc0=;
        b=WMVom1kdi6uJI3AmJ20MVa9aZkkOiskQbUXL5g3sriOLx+qnvZHr/oPODb+2JEZSj9
         phYtgO6WvEoO7E/C8gy/apJvyTV0rwnug/PXEpJdU0StyqJJSMB5rHDMGUf1jsNS2QVW
         B0X/idJ212AF4r0aQ5KukHtbuDKN+aJ6K3F8vwXUsHHfe9J4/Bnswvagex9MajQXa2P5
         5enmYFguH+UPp9Yi0BHNhqs3jjQxqA5qQK89HdzenNLransWJKJss3ydzXsWk0fkUE3/
         IgjOiVE2bvQIF9wzIspPXI9p98KfVLW+AUQKhFpmdiKcvOazY+u1D+cuU2ElFdIVI8ZW
         lKdQ==
X-Gm-Message-State: AOJu0YxNLzZnWAt1JIX/6vc7wWJbEIZyLcGU6moE+g93PVHfHmibBSEo
	KdC2mB3hBhaaHry0+CMztX8vWrbfHGtguM/rHj45KJMF
X-Google-Smtp-Source: AGHT+IEhJ+LOFPNfnFM0vMd4OleoAdb9aYJe24UJskdd5LdyMDboq8MbIZUqAdWDjoWz+tDzvJ9LLw==
X-Received: by 2002:a05:6512:3c91:b0:503:9eb:47f0 with SMTP id h17-20020a0565123c9100b0050309eb47f0mr5288729lfv.59.1697653667387;
        Wed, 18 Oct 2023 11:27:47 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id s26-20020a056402037a00b00532eba07773sm3168128edw.25.2023.10.18.11.27.46
        for <linux-hardening@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 11:27:46 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo12187057a12.3
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 11:27:46 -0700 (PDT)
X-Received: by 2002:a17:907:8687:b0:9c5:2806:72e9 with SMTP id
 qa7-20020a170907868700b009c5280672e9mr50945ejc.34.1697653645201; Wed, 18 Oct
 2023 11:27:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
 <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
 <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com> <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com>
In-Reply-To: <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 18 Oct 2023 11:27:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
Message-ID: <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To: Jeff Xu <jeffxu@google.com>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 18 Oct 2023 at 10:14, Jeff Xu <jeffxu@google.com> wrote:
>
> There is also alternative approach:
>
> For all the places that call do_vmi_munmap(), find out which
> case should ignore the sealing flag legitimately,

NO.

Christ.

THERE ARE NO LEGITIMATE CASES OF IGNORING SEALING FLAGS.

If you ignore a sealing flag, it's not a sealing flag. It's random
crap, and claiming that it has *anything* to do with security is just
a cruel joke.

Really.

Stop this. I do not want to hear your excuses for garbage any more.
We're done. If I hear any more arguments for this sh*t, I will
literally put you in my ignore file, and will auto-NAK any future
patches.

This is simply not up for discussion. Any flag for "ignore sealing" is wrong.

We do have one special "unmap" case, namely "unmap_vmas()' called at
last mmput() -> __mmput() -> exit_mmap().

And yes, that is called at munmap() time too, but that's after the
point of no return after we've already removed the vma's from the VM
lists. So it's long after any error cases have been checked.

             Linus
