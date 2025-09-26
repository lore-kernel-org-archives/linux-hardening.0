Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683F1534EC
	for <linux-hardening@vger.kernel.org>; Fri, 26 Sep 2025 04:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758859587; cv=none; b=IPgtETlouAtlapQ6zhe8OE1PbfbyPHn+D71h91fbYOZSXTJMwXWehJnF7AxhJ+XsAzPc2ZjVxqpR8kOWycCc7LQKqitYggsNccADauUpIOrp3X4wsBCK85nxfFLfky0XyjyaD5+z4prEAaJU2YWXuZUNCeFX4c3l3l1WJcfypfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758859587; c=relaxed/simple;
	bh=QN3PMqSDG+3KOmbbvDIlxDHkWx3vdvGU90SQPYHkq4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bkwZCr/mKsFVadyXGB2JBl3qnbzfdQXvR3tdA+LI+CYmOAa64BmZml6j/m4CHQ7Z87CK9tG3ml93Il7wZx7FnDrNPZsWqExD1DQYBHau89yFeK0ARSpYo3PCV3wtLIYUQ1bYnInb4UaYE2954xYQbWrDnXGTvxtHfrnn2WloA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj5TD+G6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj5TD+G6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DFBC4CEF4;
	Fri, 26 Sep 2025 04:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758859587;
	bh=QN3PMqSDG+3KOmbbvDIlxDHkWx3vdvGU90SQPYHkq4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj5TD+G6wPT0s6CaPgID2bE9HaoLi+bINTv5Pq1gzLR98uh9FatBrtfHbrTQnYU1j
	 kLfxKZtUMrcXaWZkKSUzl91YmIiC6v7Zz6hEPi8wsUcHV6Z6q3Lej0FXYdnagvVFhW
	 BNX9qm8deZmY80dqA5SiCO2fztgVaDx2Eg1I6w6PjZgNgLbfcNdYVDhI5WDj8Ugsl2
	 Hd+yKA0IMsKfQtMSf6Sip4K2B5cR4zPjqL+ud03dDIQ30ReJiNmCqclwZ4ygEt154f
	 ENaSilK+1PjKHqFVV76fjQwTCT1piQAFe6OL1qF/ccVApI0v1xQs993XDi/ZUHyVO/
	 +/OA4HzDiDtiA==
Date: Thu, 25 Sep 2025 21:06:26 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
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
	Bill Wendling <morbo@google.com>, gcc-patches@gcc.gnu.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm: Add ARM 32-bit Kernel Control Flow Integrity
 implementation
Message-ID: <202509252105.CCE8EAC20@keescook>
References: <20250926023737.it.616-kees@kernel.org>
 <20250926030252.2387681-6-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250926030252.2387681-6-kees@kernel.org>

On Thu, Sep 25, 2025 at 08:02:48PM -0700, Kees Cook wrote:
> Assembly Code Pattern for ARM 32-bit:
>   push {r0, r1}                ; Spill r0, r1
>   ldr  r0, [target, #-4]       ; Load actual type ID from preamble
>   movw r1, #type_id_low        ; Load expected type (lower 16 bits)
>   movt r1, #type_id_high       ; Load upper 16 bits with top instruction
>   cmp  r0, r1                  ; Compare type IDs directly
>   pop [r0, r1]                 ; Reload r0, r1
>   beq  .Lkcfi_call             ; Branch if typeids match
>   .Lkcfi_trap: udf #udf_value  ; Undefined instruction trap with encoding
>   .Lkcfi_call: blx/bx target   ; Execute validated indirect transfer

Agh, I missed changing this part of the commit log to reflect the new
eor sequence. I'll get that fixed.

-- 
Kees Cook
