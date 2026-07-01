Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41B52737E3;
	Wed,  1 Jul 2026 08:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893693; cv=none; b=A4/pQ62kDWbxIQaXzDI94lCE/0n2fRParD2Ey99gLi/rcnWCvG9S/qgoeDcyFR09z8Tng1++B/29l+pAi8gZEz/w6V45Cxa7Hl0R+/BHNuNAXhtzUkiuxZ574L0SwxYsJhZMBdeFIYdeASmy2Sxti6UH/4DzOU1AXz+h1krVwSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893693; c=relaxed/simple;
	bh=39pxWTxF9Nhuc3P0AQwydW+MAWu+cXbgi7YtbqzrXuU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Sg951r4yw+g+aC8xBMxlH8KSFyXuBoUy0BdvDzDR4cD/P1YV8t2L4zn+/cc+epsmRSg3qrOOXuH+1p7ohKP1jPdnAmpFSQvY1Ve+7hWk5L0STEvn1YrK8CitdTNKcWlUEqVEFIL1Db1yM+b6mCCeq/7rkflP4BVOjBIo/frCDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=WwYb6t3M; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="WwYb6t3M"
Received: from ehlo.thunderbird.net (c-76-133-66-138.hsd1.ca.comcast.net [76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 6617wJqg986666
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 1 Jul 2026 00:58:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 6617wJqg986666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2026062701; t=1782892700;
	bh=svsw8bf09g8hVr5lTGfzTsOW2DVBVtdsm1cgrew8gy0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WwYb6t3MOkJNASrSHK3PxMbAVLdL9nZ+N2HEetPR//ORAluvuOcgDHW0bq049woTd
	 PYwLvJZ9tEekKWQKgKe11KyOI/RTT0I6fOyzEa7T3nP7p616hJM8BpBlKrVhBryGOs
	 Y/AUVdrqJLlB0LdVD8tqhHXzp/7Go6Ha7etS+gpZmy6IsRx6/1gSjcqYwRTwFo9kj5
	 eJ4ABsfjsZbiFnaLj1lY/1gk5Kcy7ED/k7Ml6p9R6NBRKXt17lcDdODcQhbe7uwtz2
	 AWZxnXx1hr+7xuzrBdmOSvXET0xwgMnvk4ootLHSsvX5sJO36PDnQtHORLCqezF3tP
	 Bn5IqhCHAYzrA==
Date: Wed, 01 Jul 2026 00:58:12 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Peter Zijlstra <peterz@infradead.org>, Dave Hansen <dave.hansen@intel.com>
CC: Xiang Mei <xmei5@asu.edu>, Kees Cook <kees@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-hardening@vger.kernel.org, Uladzislau Rezki <urezki@gmail.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Jennifer Miller <jmill@asu.edu>,
        Tiffany Bao <tbao@asu.edu>, Ruoyu Wang <fishw@asu.edu>,
        Adam Doupe <doupe@asu.edu>, Kyle Zeng <zengyhkyle@asu.edu>,
        Yan Shoshitaishvili <yans@asu.edu>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_mm/vmalloc=3A_widen_guard_?=
 =?US-ASCII?Q?region_to_defeat_ENTER-based_stack_pivot?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20260701074834.GI49529@noisy.programming.kicks-ass.net>
References: <20260629214712.1198680-1-xmei5@asu.edu> <d9775951-fe04-4d1f-b205-bd4626590f5e@intel.com> <20260701072747.GN48970@noisy.programming.kicks-ass.net> <20260701074834.GI49529@noisy.programming.kicks-ass.net>
Message-ID: <8730D74D-6395-4FF4-B9F9-06AFABBF8CDE@zytor.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On July 1, 2026 12:48:34 AM PDT, Peter Zijlstra <peterz@infradead=2Eorg> wr=
ote:
>On Wed, Jul 01, 2026 at 09:27:47AM +0200, Peter Zijlstra wrote:
>> On Mon, Jun 29, 2026 at 03:29:50PM -0700, Dave Hansen wrote:
>>=20
>> > But, really, if ENTER is so evil and nobody uses it, shouldn't we jus=
t
>> > have an MSR bit somewhere to tell the CPU to #UD for it rather than
>> > playing these stack games?
>>=20
>> For supervisor mode only, I suppose=2E We can't ever get rid of userspa=
ce
>> ENTER because legacy I suppose=2E But we can make sure the kernel is
>> clean=2E
>>=20
>> So yeah, having a knob to make supervisor-ENTER trap would be useful I
>> suppose=2E
>
>x86_64-defconfig builds clean with the below :-)
>
>
>diff --git a/tools/objtool/arch/x86/decode=2Ec b/tools/objtool/arch/x86/d=
ecode=2Ec
>index 1b387d5a195b=2E=2E9e53db863203 100644
>--- a/tools/objtool/arch/x86/decode=2Ec
>+++ b/tools/objtool/arch/x86/decode=2Ec
>@@ -642,6 +642,10 @@ int arch_decode_instruction(struct objtool_file *fil=
e, const struct section *sec
>=20
> 		break;
>=20
>+	case 0xc8:
>+		WARN("ENTER instruction at %s:%lx", sec->name, offset);
>+		break;
>+
> 	case 0xc9:
> 		/*
> 		 * leave

The problem is that it being a single byte long it can appear in the middl=
e of another instruction=2E=20

ENTER was primarily designed for languages with nested local scopes, for w=
hich it can do quite a bit of work=2E
