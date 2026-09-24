Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B18318ED2
	for <linux-hardening@vger.kernel.org>; Thu, 24 Sep 2026 03:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790222119; cv=none; b=GqmV49OVmjrMNs4c9K3c2V8Av7RU/pZN+KnlCs99zXI4hdObZcsQrs/GB3FD5uMmevXjb9AJif1QyNwzENcneLpIiBsaEikQZbXLsKBym/eg7ZdnBDsao/1wqZiU96UZxmtBb4v/Q/JAWV2qM7DcwnRnm26JoEX1biotvSrai9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790222119; c=relaxed/simple;
	bh=yKx2agzNj7Gh9zIpJiEsj5nFf9N4nOcw3CNqNFnwPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2zg54YDfAliQP809gZgCccw971UKRWO39vX5Hb31twQ6vv61QKcWKWkuh0Ox18oRPnqF0sdZTCoPq969iKysTaBDno1R/W598s4U9qy40eVN1OkzmDTIzwDhzrtx7vpxjO3kfBaD5aALECZejQITwZC5X0d6oh7QBMQ6T1Xi6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW95bxhz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW95bxhz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED5C1F000FF;
	Thu, 24 Sep 2026 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790222117;
	bh=+zjJatlTG1WhA+ocz2jTcfhEGpxRTvaHZW/0jSt0CIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BW95bxhzd8rYOLgrdOyAHcfLtX+CPibGt0wE7m5BkiVqI4lwP5R9AYuOBK9dqBtU+
	 1AbJL40P1tyZ3N3lgtusCNUfYnieZ6uOoVDJjXhCmX+NwPQm0wXfo9Tr1z9eCBv+ub
	 Ee9EcCNsMlZrK9kH0dqRzCNV7V6jjM9gYSk80HqesmsY0163mPn/59WV3rqcycKFzK
	 muvne7jwyRHijGEkCOPKDZFhQIDuYoA93m+ootTYHQus3W1xh4h+LwLi0uTjRJ/YX+
	 lWZMeXlgBzKo5kmf7QqJ7j6PJxw1uYbt5yl2CqpNCAwKVOaAcm2KTmlFv1s82X5oGa
	 eqpb/XilBg99A==
Date: Wed, 23 Sep 2026 20:55:17 -0700
From: Kees Cook <kees@kernel.org>
To: Juergen Christ <jchrist@linux.ibm.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Richard Biener <rguenther@suse.de>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v15 1/7] kcfi: Introduce KCFI typeinfo mangling API
Message-ID: <202609232054.5116AADA@keescook>
References: <20260825235748.i.456-kees@kernel.org>
 <20260825235759.3379064-1-kees@kernel.org>
 <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <283975a8-ccf6-4a3a-9a9b-4bc450657bbf-jchrist@linux.ibm.com>

On Wed, Sep 23, 2026 at 11:25:07AM +0200, Juergen Christ wrote:
> thanks for your work on this.  I will implement the s390x specific
> part once this series is accepted.

Great; thank you!

> I looked at this on s390x.  We actually change the mangling of long
> double if we are on a target where long double is 128bit IEEE to a
> "g".  This causes this self-test to fail.  I suggest to add this patch
> on top of our patch to fix this:
> 
> diff --git a/gcc/kcfi-typeinfo.cc b/gcc/kcfi-typeinfo.cc
> index b6723fac48da..fab06249ae16 100644
> --- a/gcc/kcfi-typeinfo.cc
> +++ b/gcc/kcfi-typeinfo.cc
> @@ -659,7 +659,14 @@ test_typeinfo_basic_types ()
>    ASSERT_STREQ ("y", kcfi_test_mangle (long_long_unsigned_type_node).c_str ());
>    ASSERT_STREQ ("f", kcfi_test_mangle (float_type_node).c_str ());
>    ASSERT_STREQ ("d", kcfi_test_mangle (double_type_node).c_str ());
> +#if defined (__s390x__)
> +  if (TARGET_LONG_DOUBLE_128)
> +    ASSERT_STREQ ("g", kcfi_test_mangle (long_double_type_node).c_str ());
> +  else
> +    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> +#else
>    ASSERT_STREQ ("e", kcfi_test_mangle (long_double_type_node).c_str ());
> +#endif
>  }
>  
>  /* Test mangling of pointer types.  */

So this portion is only needed once there is s390 support? I'm unclear
on patch ordering.

-Kees

-- 
Kees Cook
