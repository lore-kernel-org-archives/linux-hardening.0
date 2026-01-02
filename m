Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B57165F16
	for <linux-hardening@vger.kernel.org>; Fri,  2 Jan 2026 03:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767325372; cv=none; b=FcsPa+gsJxGwHmkQWM9/q6ZYkTUgQh/O9JDQRJRfUp1GgeAkX0gH1Y0giqm2lXprKhzgSDYu8P3IMoamptwrCfohccioLAycEs9O/EaNH3ICfVnQVVDSTxNu7Vt+IP91Y/TmwwsNNnKvL39o6pGppy0naErPOymTDmhRPz+1Qa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767325372; c=relaxed/simple;
	bh=R0KEIlQUa1vZv9HoFlDoefC8aZkJqHT1nDiDpz/DrSQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=F/2zT9YiGkTmJZeHn9M534gXmHLNQmRUfZ1kI6LB/tGzL0FpQn5AT9upCZH2CKC5QYTeWECB8k8w2Yipny64KdKL4KZjPOcpb+P1uzv1fhmLikvAyY5PyA1wrNxJ5ob52N1XnCtU8oRLgr87VZdq2QjN9Ynfk49Fw2l8bTSMZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rvpw7/wt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rvpw7/wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C464C4CEF7;
	Fri,  2 Jan 2026 03:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767325372;
	bh=R0KEIlQUa1vZv9HoFlDoefC8aZkJqHT1nDiDpz/DrSQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Rvpw7/wtxSqz0X7bV1e6xBk67IXSn6/FQBWFSXZmuLbr4ATIe0b/Vcczp80Z3OAd5
	 6zknTVwj95vCf7gQtVDq/1zmzzSjX1iNYbUChLPJgGAw/5jm1daBsuOpnG2gt2GKPb
	 at/SZwX3En6GW2A9IbsrTLcbTnav+OjtXIUtMlhch65J0bH4tIeAoYIrDVBdwdYyIV
	 fqPeDtwDg+FMjARf3Z7dZiklt3/a7O+Isr/mpmgauvIQ8qgnXffTy8vZ04koYAHcep
	 pnoB0BWiXE4NWY14xayICeZe7zjYFw6GJmuVxtLLIK465hCSXJw4zmJ1OEJP2gwmnb
	 8ARiRZBz50ImQ==
Date: Thu, 01 Jan 2026 19:42:50 -0800
From: Kees Cook <kees@kernel.org>
To: Andrew Pinski <andrew.pinski@oss.qualcomm.com>
CC: Qing Zhao <qing.zhao@oracle.com>, Uros Bizjak <ubizjak@gmail.com>,
 Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
 Jeff Law <jeffreyalaw@gmail.com>, Andrew Pinski <pinskia@gmail.com>,
 Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
 Peter Zijlstra <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jan Hubicka <hubicka@ucw.cz>, Richard Earnshaw <richard.earnshaw@arm.com>,
 Richard Sandiford <richard.sandiford@arm.com>,
 Marcus Shawcroft <marcus.shawcroft@arm.com>,
 Kyrylo Tkachov <kyrylo.tkachov@arm.com>, Kito Cheng <kito.cheng@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Andrew Waterman <andrew@sifive.com>,
 Jim Wilson <jim.wilson.gcc@gmail.com>, Dan Li <ashimida.1990@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 Ramon de C Valle <rcvalle@google.com>,
 Joao Moreira <joao@overdrivepizza.com>,
 Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
 "Osterlund, Sebastian" <sebastian.osterlund@intel.com>,
 "Constable, Scott D" <scott.d.constable@intel.com>, gcc-patches@gcc.gnu.org,
 linux-hardening@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v9_0/7=5D_Introduce_Kernel_?=
 =?US-ASCII?Q?Control_Flow_Integrity_ABI_=5BPR107048=5D?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
References: <20251210022025.harder.803-kees@kernel.org> <CALvbMcACT19UHPJme0w1rStX5XEJwNWdAMTuJ=cERkY38+EMQg@mail.gmail.com>
Message-ID: <269C524E-2FDB-4156-98FE-548993666B03@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On January 1, 2026 2:42:59 PM PST, Andrew Pinski <andrew=2Epinski@oss=2Equ=
alcomm=2Ecom> wrote:
>On Tue, Dec 9, 2025 at 6:22=E2=80=AFPM Kees Cook <kees@kernel=2Eorg> wrot=
e:
>>
>> Hi,
>>
>> This series implements[1][2] the Linux Kernel Control Flow Integrity
>> ABI, which provides a function prototype based forward edge control flo=
w
>> integrity protection by instrumenting every indirect call to check for
>> a hash value before the target function address=2E If the hash at the c=
all
>> site and the hash at the target do not match, execution will trap=2E
>>
>> I'm hoping we can land front- and middle-end and do architectures as
>> they also pass review=2E What do folks think? I'd really like to get th=
is
>> in a position where more people can test with GCC snapshots, etc=2E
>
>So looking back into the other implementation that was submitted a few
>years back (https://patchwork=2Esourceware=2Eorg/project/gcc/patch/202303=
25081117=2E93245-3-ashimida=2E1990@gmail=2Ecom/),
>a regnote (REG_CALL_CFI_TYPEID) was used instead of the wrapping with
>kfci rtl=2E
>I get the feeling a regnote would be better as there is less for the
>backend to deal with including new patterns=2E
>What do others think?

I started there and it created way too many problems that I had to continu=
ously hack around=2E Switching to RTL solved all of it=2E (See v1 and v2 of=
 this series where that was how it was implemented=2E)

-Kees


--=20
Kees Cook
