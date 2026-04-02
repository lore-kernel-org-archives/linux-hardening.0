Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77961A6822
	for <linux-hardening@vger.kernel.org>; Thu,  2 Apr 2026 17:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149545; cv=none; b=Ad/p4U9clIGWd5QdKAxHzGjKQ7q8GqkvlMhipqcZ1/0sCmA5/pUtXHssUk38hLgwQmJiBnytK5AwfXJR8ETTrpn447pHdf2+HT/yS4H7z3gRWdoqnOPWlGm+X3FG5s2KRWQaZ+FbnGh859iHxUizREZv/ISvMixSwUrftrlyrX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149545; c=relaxed/simple;
	bh=Zo8OAngOh0P8c1OR78bqc8BgST7jOqfQbaCLKvgsal8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AHbu7qZ0muMtt4i926hXLWt9ebM8rHuZ8K6ktOQAgFxCjz/8xDDjFRh8lTBsljpcddylYgJi1Uf0AVonp2AOycL5+cGpmWK/NhwJ0Z51SvT7vtcHEknxPNiohuweRMJ8w33o6Ggall+tYYjEX1Oe05KatFGLmh2s5cmYH4MOdvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WjLk+B+S; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLk+B+S"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4887ca8e529so8439485e9.0
        for <linux-hardening@vger.kernel.org>; Thu, 02 Apr 2026 10:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775149534; x=1775754334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ96XmrvwmNmdc1Ry2/PJXAWh8krLD6ljIYp6nVbJmg=;
        b=WjLk+B+SlJ46EL88K6CreuBSgDMyUHEBeWLKd2Bi+PUN/iHaMS6QtCdarA0ZfH+Zrq
         Srrl1ifH5TtI7OMW3xrj0qN6E4VndG5nokYMSN1eYIZcJ8jkvuPJNdNKGhB3z5O/TrR8
         ii9DG3rPWF0mIBkR4PqjXOw5HwYEBlF3zfafHabMyjCSYh3eAasYrx/8+u6SR60lJZPY
         WKWC5aNcthE83iUpuHi6baRXcT6iBxFfaXSyIayqtSBZlDKLWowZwYcirMS1p/MrgBN4
         TlavIYBFG/nTd2AtAp2bHVTvVAFcDB9Yq9AiD/4XLqRpRCp7TqBtHGCVo7QqHxvdZXs7
         IgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775149534; x=1775754334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJ96XmrvwmNmdc1Ry2/PJXAWh8krLD6ljIYp6nVbJmg=;
        b=RDZrtr/6iKuNIEO0HHIwPjRy1yPC6ANA7U30GeifDbQihd+BpaCBfh/8YLxNW8ZDgw
         HCJ74UD2xRyING6ON5WUmcTblt7pNB+sDlrxeg+oQn2JanCTpTWUfRn+q+LJ49R5ul7M
         LAY+Ocp8LLZFeh3//FqJl9pz2tf9H+AJNsALsOFT9uXqQY8oAeZ62uaQ8lrClpgsxLSO
         eqszf2OBs9Gye9wMOjkABpdfM9Yz23efPXLCipRgtD15PtWmc3JxmDjjpu/VSiTPnO4r
         Z/GQaLMH5ePrDcDJKQKUsKOH3brpdoK0mfh/XSHp4l4qTHMA2VWRh1PENGYLf/xjrCRB
         KCHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPseJatCOPr5eeuhWak+Af6zUYwQ8siwmBZLV6YKmUyjezquvFHNchrqYyjm0QjzhMWT9DL1RDSxx5BCQE4Jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbKC+dXxcEwziiy5za6Y7SMeLsJv+TUMHRA8fAev0a4D0F0TJA
	j4z2QUwyjd1zHcGqmGZv7PbiHE30XBnBRDgQw+257X7MfYECJC9Pf8m6
X-Gm-Gg: ATEYQzza7sv7NxP6+a2GNpZ82CTpytatldH9Qj7oZ4+ASAnY/GuAqz+kvVwNTRBVEDG
	DZ+RZ+TrkXmq+o9oyeERfjtqKvkDTVgcXijZpdmidStRHbT7CGB9PHatmqVn9369DeydrbVnZIq
	OqKDcAOL6CgfqLWRsJmnv2LHfS0xfyk4RJVMZp9nSuP8/uPBAoXavLBMb2a1/8TnumNDe58+cjk
	wJbddS+Gn1es8rmO6yHD0Yg1nMGYmklu92+qYmO/PU9QBHbcd16GkLz6LByevXCRPxoC1OwA/EJ
	G+i/Sb/CMFLmpypVPOCLRJtxVg0BNp+n11/FHFuzaeI5ujxFuAXgSu8h1iVh0DBzrCcLolGgDEy
	H7jeYW7tOep5m4kJf2Riuy4XlZoapns1Wdwr7RBF2qDje/ANUO/eEVCYekL4kR+xVYk4ms9WsYs
	8gtL1reWWRhLwL7rXhpYA=
X-Received: by 2002:a05:600c:3b0a:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-4888e09ba82mr46503895e9.10.1775149534150;
        Thu, 02 Apr 2026 10:05:34 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e80a63esm265992305e9.3.2026.04.02.10.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:05:33 -0700 (PDT)
Date: Thu, 2 Apr 2026 20:05:30 +0300
From: Dan Carpenter <error27@gmail.com>
To: Marco Elver <elver@google.com>
Cc: oe-kbuild@lists.linux.dev, Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Harry Yoo <harry.yoo@oracle.com>, Hao Li <hao.li@linux.dev>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	kasan-dev@googlegroups.com
Subject: Re: [PATCH v1] slab: support for compiler-assisted type-based slab
 cache partitioning
Message-ID: <ac6h2jF-KJ5pm1WM@stanley.mountain>
References: <20260331111240.153913-1-elver@google.com>
 <202604020400.jEq32K95-lkp@intel.com>
 <CANpmjNOsM1e8jMvRKtEizMmZgPCCZ9YqpuZKad61Zg7PAGW7RA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOsM1e8jMvRKtEizMmZgPCCZ9YqpuZKad61Zg7PAGW7RA@mail.gmail.com>

On Thu, Apr 02, 2026 at 03:48:20PM +0200, Marco Elver wrote:
> On Thu, 2 Apr 2026 at 15:33, Dan Carpenter <error27@gmail.com> wrote:
> >
> > Hi Marco,
> >
> > kernel test robot noticed the following build warnings:
> >
> > https://git-scm.com/docs/git-format-patch#_base_tree_information]
> >
> > url:    https://github.com/intel-lab-lkp/linux/commits/Marco-Elver/slab-support-for-compiler-assisted-type-based-slab-cache-partitioning/20260401-035608
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> > patch link:    https://lore.kernel.org/r/20260331111240.153913-1-elver%40google.com
> > patch subject: [PATCH v1] slab: support for compiler-assisted type-based slab cache partitioning
> > config: um-randconfig-r072-20260401
> > compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> > smatch: v0.5.0-9004-gb810ac53
> >
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Reported-by: Dan Carpenter <error27@gmail.com>
> > | Closes: https://lore.kernel.org/r/202604020400.jEq32K95-lkp@intel.com/
> >
> > New smatch warnings:
> > drivers/misc/lkdtm/heap.c:118 lkdtm_READ_AFTER_FREE() warn: potential pointer math issue ('base' is a 32 bit pointer)
> > drivers/misc/lkdtm/heap.c:169 lkdtm_KFENCE_READ_AFTER_FREE() warn: potential pointer math issue ('base' is a 32 bit pointer)
> 
> How is this related to the patch I sent? Did the <linux/slab.h> change
> force rechecking of all these files and it found latent issues?
> 

Oh, crud.  It turns out that for this check Smatch allows
integer_array[sizeof()]so long as we know that the index is within
bounds.  What happened is that your patch renamed the kmalloc()
function so Smatch stopped knowing the size of the buffer.

For these zero day bot warnings, the emails are automatically generated
so I don't have any context outside what's in the email.  I saw that
Kees wrote the code, but I figured maybe you forwarded it or something.
Sorry about that.

regards,
dan carpenter

