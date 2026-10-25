Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792900490;
	b=I+gqdGMBvF2GB+Av1KOOrjOyiLJpHj7c7yi2hiDOkxuHJfP5HZu/e23d5ZLzSU7GeVeB
	 6nh+F0bSjasI8b5DUFriAGxIXA6HJvXJbCML6NC1V2HiRqp//r3lGpQpL5l3Axg4Gpqv7
	 UUeJ9hcOh1kZyeBf7rh0R4BiXv+zRlJJK1a77PKVR3K1b2Hy+AdYaK5y08s8kpx5UxXef
	 fTQrfN0+VIsF5rfpX6lcTZy4oh23PCFzGBfmODp1TNukwcmkH3biFC3/IeUV+uxtqb5r/
	 3yI+qJzyqUSizSDGjKTAvE92cTaxJieyuXqrTt7fn2AptHK+tiODhB56cVoz+5wFAUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792900490;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=WXVw4uV+QgQK0ZV4AoQcJHiCYz1bp3nkFgF0CKG9now=;
	b=Uk7eQIhWp7EUxvy6DQpYLwHgc0uf9MyIfW1HSOL47csoBSPkm4u0TE++dp+ykHUyLx/M
	 LMX7p65okCR8KEobOW/gsT1K5ep1ZF+n7bliM1ujPRsxNN4m7YzZi1/uPHsQZcQ96gl4h
	 yQ+iJChpAH9O6y/f2uXlzqd1PzZI87hxpgWklg9Py8A4ZdLr9fd2xCribsEABg3l8bcjL
	 ekI6IsIxwohCAPPJFvITyu+/46KNFxtoz9/HPJc5X5MgoZJjWNU/6ky8+yFmoLw33ccTv
	 WdgwJNrRaO7bj4dkHjhMOG1G9TUx7og9VKcAsq4G9FGCWc1cCF45MPjS6PsJdpqC+MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAfWvebe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A86606A31B
	for <linux-hardening@vger.kernel.org>; Sun, 25 Oct 2026 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PAfWvebe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AFA1F01825;
	Sun, 25 Oct 2026 03:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792900490;
	bh=WXVw4uV+QgQK0ZV4AoQcJHiCYz1bp3nkFgF0CKG9now=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PAfWvebemeEQggRe+3tB5j1qgu2A32uvRNAyxuQ6dnAPVfxrOCvVO2EVSywF+VpKK
	 NYSKhFkUAm8d6z5xXGrGwxCVTSDpkO/H5eq+lftcyUieKrerhw1zqiaF+6zhde4AFE
	 dwE+7695CcDJivIehVoJkB/vzQvmJZtB9WnS5G7MnNxo72QJlLq6t9uYEGt1yZMqO6
	 dGUmZYO5EV3TYVdc/HwhhtZWqbFvI5bxxXbM9coultOZAYuQgmhY0ElmjpPKvovzUk
	 4DpvwG7Jmvhj/nTGoDRXmzHDcp58kUqyXrxQI72X7C7A6I5Zh8euhWZsAXZHbQgTUe
	 Tb8EeBgAVF1Zg==
Date: Sat, 24 Oct 2026 20:54:49 -0700
From: Kees Cook <kees@kernel.org>
To: Jeff Law <jeffrey.law@oss.qualcomm.com>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
	Richard Biener <rguenther@suse.de>,
	Jeffrey Law <jefflaw@qti.qualcomm.com>,
	Joseph Myers <josmyers@redhat.com>,
	Jakub Jelinek <jakub@redhat.com>, Martin Uecker <uecker@tugraz.at>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
	Uros Bizjak <ubizjak@gmail.com>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Juergen Christ <jchrist@linux.ibm.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Osterlund Sebastian <sebastian.osterlund@intel.com>,
	Constable Scott D <scott.d.constable@intel.com>,
	gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v17 7/7] riscv: Add RISC-V Kernel Control Flow Integrity
 implementation
Message-ID: <202610242052.5C74E1C95@keescook>
References: <20261005154028.out.839-kees@kernel.org>
 <20261005154039.1464721-7-kees@kernel.org>
 <45190057-a50b-40f4-9502-e3001fcac67e@oss.qualcomm.com>
 <20261010075835.446f27-kees@kernel.org>
 <68806dbb-8a7e-46c7-9630-80c60de76a27@oss.qualcomm.com>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68806dbb-8a7e-46c7-9630-80c60de76a27@oss.qualcomm.com>

On Sat, Oct 24, 2026 at 08:42:32AM -0600, Jeff Law wrote:
> On 10/10/26 2:04 AM, Kees Cook wrote:
> > I'd love to, but the KCFI check is part of/within the call insn and LRA
> > allows no output reloads in a CALL_INSN:
> > 
> > 	/* CALL_INSNs are not allowed to have any output reloads.  */
> > 	if (CALL_P (curr_insn))
> > 	  no_output_reloads_p = true;
> > 
> > So under register pressure the allocator can't provide a scratch register
> > for the call pattern, so I had to have each backend instead pick scratch
> > registers that are dead at the call (caller-saved temporaries that aren't
> > argument registers or the target). I went through this with Andrea for
> > AArch64[2][3]. Moving the check out into separate insns, so that pseudos
> > would work, runs into point 1 above.
> But it'd be an input reload, not an output reload since it's reloading for
> the call address, not the result of the call.  Perhaps if the value were
> needed after the call because we made multiple indirect calls through the
> same pseudo register, the pseudo does not get a hard register and the
> indirect call insns require a call clobbered register for the call address
> -- *maybe*.  But off the top of my head I'd kind of expect that to be a
> series of input reloads rather than a series of in/out reloads.
> 
> 
> > 
> > And trying to create an entirely new mode of register allocation for
> > use within a CALL_INSN seemed like serious over-kill, given the other
> > narrow constraints on KCFI.
> Certainly wouldn't suggest that.  Just seems like standard mechanisms ought
> to be working here at least at first glance.

Is there some way to have only an input reload? I totally failed to
convince LRA to do _any_ kind of register allocation for me in these
sequences, and boy would I have preferred it do the work. ARM was
especially gross for doing this by hand.

-- 
Kees Cook
