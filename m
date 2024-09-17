Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E215D5D8;
	Tue, 17 Sep 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573413; cv=none; b=ToqmpjJd21IOhnwZ09yaiyvE2pbVdBcLtFy8XNn5e/O95Rm87XGVSItCOdHDpip1KAnwmY31YuHDLn1FkbGEcDTImLvg/WmplCuzE3FmyDFS60nv0kr6dbBBlQJODITPISh/E3T9hAXA4T1aBz8b8oi+fHc7LtxaSmYLLZSFGBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573413; c=relaxed/simple;
	bh=2Q+G1i+vqtT89tlk4lzNvsr6PjZEkQ9DtTaQmpxhxA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/vbac7dZxsOt1kHD9gjVm+v/HvLPocMWDoc/+af7m6+GhZdSzDrsYID0UNdrPLRDq2TWNgxGGtSZwYgbKQvcjpGXd6BZ7rxq8FEe0pShhmUOj0zwtDXDDees3WdcIB/Qzb6KZ6mohDsRI/neCkApclkd/ZFz+sF2iWimbgtg4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S9Cw76Og; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S9Cw76Og"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC1EC4CEC5;
	Tue, 17 Sep 2024 11:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726573412;
	bh=2Q+G1i+vqtT89tlk4lzNvsr6PjZEkQ9DtTaQmpxhxA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S9Cw76OgFMuB/QNfEYJaTS31JvkwAJgVvwiAI0vRdkH8BweUSLJc9pqWK2V6bwd02
	 DQ+x5Soj8Y/LW2DQrmy0ZtqtF9pxLecwh9q2XhXYnX9MdTVrzJWPIPvvNeX4OTZBMe
	 EuZZ6Py8gc1LWlWqhaW4z2xW0yL5q6HLwZVX0Tgz9kgVYRDrtsiuUFGseKUNU8dNP1
	 Hjd0KScJqtptwaH0hbWzPar1tJPUIQkJFv5zc7zCKj9pJlElFM4WryC3b5FOPDvwIn
	 aLo/llnR9m022cvDJ4WPCdeBJx6HoZjECTUfpMdWBQa3vAheg3F6dhwyrcHCqKTzZm
	 bXXnfBPcs/txQ==
Date: Tue, 17 Sep 2024 04:43:32 -0700
From: Kees Cook <kees@kernel.org>
To: Bill Wendling <morbo@google.com>
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	Nathan Chancellor <nathan@kernel.org>, gustavoars@kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	mcgrof@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2] params: Annotate struct module_param_attrs
 with __counted_by()
Message-ID: <202409170436.C3C6E7F7A@keescook>
References: <20240909162725.1805-2-thorsten.blum@toblux.com>
 <20240913164630.GA4091534@thelio-3990X>
 <60B48C52-12A6-4810-8C8C-9CC1C1E77E68@toblux.com>
 <20240913234455.GA1842841@thelio-3990X>
 <FF37A337-32B0-4951-B13F-2EFB1734B6DE@toblux.com>
 <CAGG=3QWawMUJv83UBGFk0izrP1+FdftB7x7ZLSYx4NvcGPWyYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGG=3QWawMUJv83UBGFk0izrP1+FdftB7x7ZLSYx4NvcGPWyYg@mail.gmail.com>

On Mon, Sep 16, 2024 at 02:45:47AM -0700, Bill Wendling wrote:
> The 4294967295 simply means "I don't know." There's probably a bug in
> the size calculation. I'll look into it.

I was able to build a minimized PoC, if that's helpful:

https://godbolt.org/z/qohGd5xh1


#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

struct variable {
        int a;
        int b;
        int length;
        short array[] __attribute__((counted_by(length)));
};

struct bucket {
        int a;
        struct variable *growable;
        int b;
};

int main(int argc, char *argv[])
{
        struct bucket *p;
        struct variable *v;

        p = malloc(sizeof(*p));
        v = malloc(sizeof(*p->growable) + sizeof(*p->growable->array) * 32);
        v->length = 32;


        printf("%zu\n", __builtin_dynamic_object_size(v->array, 1));

        p->growable = v;
        printf("%zu\n", __builtin_dynamic_object_size(p->growable->array, 1));

        return 0;
}


GCC shows 64 64, but Clang shows 64 0.

-- 
Kees Cook
