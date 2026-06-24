Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88855695;
	Wed, 24 Jun 2026 10:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297046; cv=none; b=Ag9xq9OSlsZD4N6RZ/WffIKZXog495R7+chyXmu3rF4zmN20JWkGomUBg/jwLc/JGBIsZ6AbiO4FSUjrq2GcwJAnryyWtp8n93F18shUeWXeDHgupOv1w9SMq3UNlClksvUHx0/PXccJ/N3aQKfcDQiaZfh1hEoqfA4n9V/zetQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297046; c=relaxed/simple;
	bh=yySCSDmWkSrAyKFQALj+CMp/t/7dN5oP887hZUcTXzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kr/AI4sHbzV9NokyNrxcP3cPb0Mt4t2V2SNmDI5QnHG7l4XaoVV8/vCM0RkAbf9zn1TI9fGMibhHHkflEEUe31qQCaU8fTSUfGE2c8SNvzBIfvrHck8V0r+okf6w2aaYfFd8uqpomNgYDZkL5gaGogVqnxi0C9R9qKX4VgPLHzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbeCVwgK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbeCVwgK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F72C1F000E9;
	Wed, 24 Jun 2026 10:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782297045;
	bh=QwliSSuhtfi2rG6uHV3E8T9pgBho8Hn+V/ZhnR4+vEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VbeCVwgKGKUHWH4ftJTZD/uS2m9X3Fv0e8BUb5ghAdYjPSkzyUF6P7CN++UlpOOEf
	 niQiZfwyLE+mFo1ZctLqRpDZGk7/J3Fdja/cAls51kg9GfM1cLzZqItwCF74f9QAZc
	 mlj1d1em0VLuAOTrQb7sKnOyNOOmDfZk1l2esF3MCZdyjEyXyC6T62QZznduQjvtBw
	 3efZoozwmbyU66hPexf+Ryfwz44/komgESlvKHsHjYj0y0q5AEBD9wxBP+83Wy70S/
	 aXu6nSxcQ1aq3ZLcfocfjKLB34W0xslsc6Nz6MG03RWvepGdK7ef44l0Ka9aXSuLZ6
	 q8PHgOsyQs4Yg==
Date: Wed, 24 Jun 2026 11:30:39 +0100
From: Daniel Thompson <danielt@kernel.org>
To: david.laight.linux@gmail.com
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH next] drivers/misc/kgdbts: Replace strlen() strcpy() pair
 with strscpy()
Message-ID: <ajuxzyI4_RB-R1pB@aspen.lan>
References: <20260606202744.5113-4-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260606202744.5113-4-david.laight.linux@gmail.com>

On Sat, Jun 06, 2026 at 09:27:43PM +0100, david.laight.linux@gmail.com wrote:
> From: David Laight <david.laight.linux@gmail.com>
>
> Use the result of strscpy() for the options overflow check.
> Use two argument strscpy(config, kmessage) to ensure no overflow.
>
> Signed-off-by: David Laight <david.laight.linux@gmail.com>
> ---
> This is one of a group of patches that remove potentially unbounded
> strcpy() calls.
>
> They are mostly replaced by strscpy() or, when strlen() has just been
> called, with memcpy() (usually including the '\0').
>
> Calls with copy string literals into arrays are left unchanged.
> They are safe and easily detected as such.
>
> The changes were made by getting the compiler to detect the calls and
> then fixing the code by hand.
>
> Note that all the changes are only compile tested.
>
> Some Makefiles were changed to allow files to contain strcpy().
> As well as 'difficult to fix' files, this included 'show' functions
> as they really need to use sysfs_emit() or seq_printf().
>
> All the patches are being sent individually to avoid very long cc lists.
> Apologies for the terse commit messages and likely unexpected tags.
> (There are about 100 patches in total.)
>
>  drivers/misc/kgdbts.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 9d3218330f0a..2c8f10b8ac74 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -1069,11 +1069,10 @@ static void kgdbts_run_tests(void)
>
>  static int __init kgdbts_option_setup(char *opt)
>  {
> -	if (strlen(opt) >= MAX_CONFIG_LEN) {
> +	if (strscpy(config, opt) < 0) {
> +		config[0] = 0;

This line isn't mentioned in the description.


Daniel.


>  		printk(KERN_ERR "kgdbts: config string too long\n");
> -		return 1;
>  	}
> -	strcpy(config, opt);
>  	return 1;
>  }
>
> @@ -1144,7 +1143,7 @@ static int param_set_kgdbts_var(const char *kmessage,
>
>  	/* Only copy in the string if the init function has not run yet */
>  	if (configured < 0) {
> -		strcpy(config, kmessage);
> +		strscpy(config, kmessage);
>  		return 0;
>  	}
>
> @@ -1153,7 +1152,7 @@ static int param_set_kgdbts_var(const char *kmessage,
>  		return -EBUSY;
>  	}
>
> -	strcpy(config, kmessage);
> +	strscpy(config, kmessage);
>  	/* Chop out \n char as a result of echo */
>  	if (len && config[len - 1] == '\n')
>  		config[len - 1] = '\0';
> --
> 2.39.5
>
