Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B252853E0;
	Sat, 22 Nov 2025 04:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763787099; cv=none; b=ko1BWgaCyXBPknA6uzyPyJ48RD0EsHykgim1MtoolpiAiy7wPtioKCyNg9ySrp/xAU+B3VAZKljKb6DWYkk+38CESg9j4GcL7+lY1ZapZQOcM1syhyxnS6h1S7RDPCMZ179s3UPVVKBVMxzP4ikq49slXJ7Ey/7sLTZ7HGJxEkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763787099; c=relaxed/simple;
	bh=7SzEtoD3Q2SJNKtinN/vaZ2Gu8lnZev6twaNqAR+dDk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b9Ohs+DBSpj8dNlmQkunQ2uYZROtrEsMHVl9yzJbUwtTOtz3cM3Vw/5tNtM8JsaQ93D1onVDOGsXfa13X1ogBqJnr4AKGpBw8ZLe2R+bMdsgZsXoJ2ohNH5WgVy8c5PXl6/NcrLY1oW+utzvai7SZpzTzKaM0b7EtX38oWVomeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A5B841607B4;
	Sat, 22 Nov 2025 04:51:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf14.hostedemail.com (Postfix) with ESMTPA id C6BA130;
	Sat, 22 Nov 2025 04:51:20 +0000 (UTC)
Message-ID: <f1d2bb84df85237f23ebf6e0f3dfecfd72d615b6.camel@perches.com>
Subject: Re: [PATCH v5 3/4] checkpatch: Suggest kmalloc_obj family for
 sizeof allocations
From: Joe Perches <joe@perches.com>
To: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Cc: Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>,  Lukas Bulwahn <lukas.bulwahn@gmail.com>, Randy
 Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>,  Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Linus Torvalds	 <torvalds@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>,  Christoph Lameter	 <cl@linux.com>,
 Marco Elver <elver@google.com>, Vegard Nossum	 <vegard.nossum@oracle.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes	 <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>, Andrew Morton	
 <akpm@linux-foundation.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>, Justin
 Stitt	 <justinstitt@google.com>, Jann Horn <jannh@google.com>, Greg
 Kroah-Hartman	 <gregkh@linuxfoundation.org>, Sasha Levin
 <sashal@kernel.org>, 	linux-mm@kvack.org, Nathan Chancellor
 <nathan@kernel.org>, Peter Zijlstra	 <peterz@infradead.org>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>,  Jonathan Corbet	
 <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, Yafang Shao	
 <laoar.shao@gmail.com>, Tony Ambardar <tony.ambardar@gmail.com>, Alexander
 Lobakin <aleksander.lobakin@intel.com>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Alexander Potapenko	 <glider@google.com>, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev
Date: Fri, 21 Nov 2025 20:51:19 -0800
In-Reply-To: <20251122014304.3417954-3-kees@kernel.org>
References: <20251122014258.do.018-kees@kernel.org>
	 <20251122014304.3417954-3-kees@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: C6BA130
X-Stat-Signature: y1e6wye49h55e9yihtz99bqq8wccka44
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Sr1JQ+437w6kkX38ORxtyNSi2FQhscRU=
X-HE-Tag: 1763787080-150056
X-HE-Meta: U2FsdGVkX1+M0hbju6B4R0TNwI2E2iep66FeX6Que0tNsb+p8wMZ25hWgq/0Vg70NWm4auf2lfTvdpVhLVnfB1hBlf5wFSevwBSyC6wNObgGWMSG0iH9DzDUrYTNDo1mwj53A3UlpMDs/Z2ciaydLxUjMSIkc3wYa0yAFskiGr3Tq2v2v12WwDKOLviXDa9mthgm8+7cSFMGd5Waqo5a6wL6Mgv1Le1Mknb+2EzvfPlMA8grKHD5zYIb6mFlNhPbNWs5Ml0iBRYXn8u6C5HyT5LVyPiZlIL+x5IRaAH/Pm0+Q/OzWQjOGYlSjR+teOoC

On Fri, 2025-11-21 at 17:42 -0800, Kees Cook wrote:
> To support shifting away from sized allocation towards typed
> allocations, suggest the kmalloc_obj family of macros when a sizeof() is
> present in the argument lists.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -7258,17 +7258,42 @@ sub process {
>  			    "Prefer $3(sizeof(*$1)...) over $3($4...)\n" . $herecurr);
>  		}
> =20
> -# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_array/=
kvmalloc_array/kvcalloc/kcalloc
> +# check for (kv|k)[mz]alloc that could be kmalloc_obj/kvmalloc_obj/kzall=
oc_obj/kvzalloc_obj

There are _way_ too many of these existing uses to suggest this change
in existing files so please add '&& !$file' to these tests

> +		if ($perl_version_ok &&
> +		    defined $stat &&
> +		    $stat =3D~ /^\+\s*($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|=
k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/) {
> +			my $oldfunc =3D $3;
> +			my $a1 =3D $4;
> +			my $newfunc =3D "kmalloc_obj";
> +			$newfunc =3D "kvmalloc_obj" if ($oldfunc eq "kvmalloc");
> +			$newfunc =3D "kvzalloc_obj" if ($oldfunc eq "kvzalloc");
> +			$newfunc =3D "kzalloc_obj" if ($oldfunc eq "kzalloc");
> +
> +			if ($a1 =3D~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/) {
> +				my $cnt =3D statement_rawlines($stat);
> +				my $herectx =3D get_stat_here($linenr, $cnt, $here);
> +
> +				if (WARN("ALLOC_WITH_SIZEOF",
> +					 "Prefer $newfunc over $oldfunc with sizeof\n" . $herectx) &&
> +				    $cnt =3D=3D 1 &&
> +				    $fix) {
> +					$fixed[$fixlinenr] =3D~ s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\=
s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*,/$1 =3D $newfunc($a1,/;
> +				}
> +			}
> +		}
> +
> +
> +# check for (kv|k)[mz]alloc with multiplies that could be kmalloc_objs/k=
vmalloc_objs/kzalloc_objs/kvzalloc_objs
>  		if ($perl_version_ok &&
>  		    defined $stat &&
>  		    $stat =3D~ /^\+\s*($Lval)\s*\=3D\s*(?:$balanced_parens)?\s*((?:kv|=
k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)\s*,/) {
>  			my $oldfunc =3D $3;
>  			my $a1 =3D $4;
>  			my $a2 =3D $10;
> -			my $newfunc =3D "kmalloc_array";
> -			$newfunc =3D "kvmalloc_array" if ($oldfunc eq "kvmalloc");
> -			$newfunc =3D "kvcalloc" if ($oldfunc eq "kvzalloc");
> -			$newfunc =3D "kcalloc" if ($oldfunc eq "kzalloc");
> +			my $newfunc =3D "kmalloc_objs";
> +			$newfunc =3D "kvmalloc_objs" if ($oldfunc eq "kvmalloc");
> +			$newfunc =3D "kvzalloc_objs" if ($oldfunc eq "kvzalloc");
> +			$newfunc =3D "kzalloc_objs" if ($oldfunc eq "kzalloc");
>  			my $r1 =3D $a1;
>  			my $r2 =3D $a2;
>  			if ($a1 =3D~ /^sizeof\s*\S/) {
> @@ -7284,7 +7309,9 @@ sub process {
>  					 "Prefer $newfunc over $oldfunc with multiply\n" . $herectx) &&
>  				    $cnt =3D=3D 1 &&
>  				    $fix) {
> -					$fixed[$fixlinenr] =3D~ s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\=
s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' =3D ' . "$=
newfunc(" . trim($r1) . ', ' . trim($r2)/e;
> +					my $sized =3D trim($r2);
> +					$sized =3D~ s/^sizeof\s*\S\(?([^\)]*)\)?$/$1/;
> +					$fixed[$fixlinenr] =3D~ s/\b($Lval)\s*\=3D\s*(?:$balanced_parens)?\=
s*((?:kv|k)[mz]alloc)\s*\(\s*($FuncArg)\s*\*\s*($FuncArg)/$1 . ' =3D ' . "$=
newfunc(" . $sized . ', ' . trim($r1)/e;
>  				}
>  			}
>  		}
