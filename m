Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E393ABA2D;
	Tue,  4 Mar 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741132573; cv=none; b=Rm3M/r7hE82bXQJDXR6it+VX0imu7Q1vZbZfrc6SUMfBZ8iIrlC7mqXdAHniFwy9LuTG1it9mtf0m6te5RZeLwiVXzwingfZEoJGV8KBBXXHpn2/KW33uRM68JNysvjFbOfhKJv0fldipmQ+z15l3XJ+s0PoBeYgmTX6XRhlAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741132573; c=relaxed/simple;
	bh=muDJG8whIoMqiQJ5GfOZ+KWXgtVcQh6PhNF7olCnVa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EB8gt7QZ1pCo706HyfOckYaN39+41DUqjw+fDaE+iwCwgqfeqctXhYUygLP/0hJzzrXq6L8Ia1kZXcR8uhTzrZGs/yHz5Rgpr8EI54wOlzU96k4gqFH52pHiajwU0+IGRZuVk60It3RjocYRXqv4s6j9L/G1SuRJOueGOR42yAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VA1ovAlv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VA1ovAlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF9CC4CEE5;
	Tue,  4 Mar 2025 23:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741132572;
	bh=muDJG8whIoMqiQJ5GfOZ+KWXgtVcQh6PhNF7olCnVa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VA1ovAlvnmYmf0qjJqlPtG/z76MWxXzAxNBM03e8cGG1YC8SJfahHPXFozqYs4KJ0
	 WuXUezrkhXSLAPnn4qdKc87YFiXwNEBr/v20YvC8qkAiLrXQnRp/mvAFWgWYTH/tY3
	 iIH59St+p0cy3PeIFjgrkoKdWNn6ZerMey2Y3wT48liS08UPeAuuVx7SgMYsAEcYm7
	 hN6394xtRnOWp7OkONDcSFbu/7VcMgaQbOZ0PMRmAsa90ztUqavTYDtonkbY1o6ze/
	 Cu0BWkYvpkVMmz8HjEpzjLV0R1duEp8yOv3fxsp27G+D2EOvHstDDhIJnwcrnWey1L
	 5LTHmcyLNCIRQ==
Date: Tue, 4 Mar 2025 15:56:09 -0800
From: Kees Cook <kees@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Bill Wendling <morbo@google.com>,
	llvm@lists.linux.dev, Geert Uytterhoeven <geert+renesas@glider.be>,
	David Gow <davidgow@google.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kunit/stackinit: Use fill byte different from Clang i386
 pattern
Message-ID: <202503041554.EB11964@keescook>
References: <20250304225606.work.030-kees@kernel.org>
 <db7mpp7nhhlnt6shpwkz4tkhftbedup7xq5zdgmn5lj23fcfq5@pulrtzlamrql>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db7mpp7nhhlnt6shpwkz4tkhftbedup7xq5zdgmn5lj23fcfq5@pulrtzlamrql>

On Tue, Mar 04, 2025 at 03:13:20PM -0800, Justin Stitt wrote:
> Hi,
> 
> On Tue, Mar 04, 2025 at 02:56:11PM -0800, Kees Cook wrote:
> > The byte initialization values used with -ftrivial-auto-var-init=pattern
> > (CONFIG_INIT_STACK_ALL_PATTERN=y) depends on the compiler, architecture,
> > and byte position relative to struct member types. On i386 with Clang,
> > this includes the 0xFF value, which means it looks like nothing changes
> > between the leaf byte filling pass and the expected "stack wiping"
> > pass of the stackinit test.
> > 
> > Use the byte fill value of 0x99 instead, fixing the test for i386 Clang
> > builds.
> > 
> > Reported-by: ernsteiswuerfel
> > Closes: https://github.com/ClangBuiltLinux/linux/issues/2071
> > Fixes: 8c30d32b1a32 ("lib/test_stackinit: Handle Clang auto-initialization pattern")
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Nathan Chancellor <nathan@kernel.org>
> > Cc: Bill Wendling <morbo@google.com>
> > Cc: Justin Stitt <justinstitt@google.com>
> > Cc: llvm@lists.linux.dev
> > ---
> >  lib/tests/stackinit_kunit.c | 30 ++++++++++++++++++++----------
> 
> Ah, couldn't find this file at first. Depends on [1].
> 
> >  1 file changed, 20 insertions(+), 10 deletions(-)
> > 
> > diff --git a/lib/tests/stackinit_kunit.c b/lib/tests/stackinit_kunit.c
> > index 135322592faf..63aa78e6f5c1 100644
> > --- a/lib/tests/stackinit_kunit.c
> > +++ b/lib/tests/stackinit_kunit.c
> > @@ -184,6 +184,15 @@ static bool stackinit_range_contains(char *haystack_start, size_t haystack_size,
> >  #define INIT_UNION_assigned_copy(var_type)		\
> >  	INIT_STRUCT_assigned_copy(var_type)
> >  
> > +/*
> > + * The "did we actually fill the stack?" check value needs
> > + * to be neither 0 nor any of the "pattern" bytes. The
> > + * pattern bytes are compiler, architecture, and type based,
> > + * so we have to pick a value that never appears for those
> > + * combinations. Use 0x99 which is not 0xFF, 0xFE, nor 0xAA.
> > + */
> > +#define FILL_BYTE	0x99
> > +
> >  /*
> >   * @name: unique string name for the test
> >   * @var_type: type to be tested for zeroing initialization
> > @@ -206,12 +215,12 @@ static noinline void test_ ## name (struct kunit *test)		\
> >  	ZERO_CLONE_ ## which(zero);				\
> >  	/* Clear entire check buffer for 0xFF overlap test. */	\
> >  	memset(check_buf, 0x00, sizeof(check_buf));		\
> > -	/* Fill stack with 0xFF. */				\
> > +	/* Fill stack with FILL_BYTE. */			\
> >  	ignored = leaf_ ##name((unsigned long)&ignored, 1,	\
> >  				FETCH_ARG_ ## which(zero));	\
> > -	/* Verify all bytes overwritten with 0xFF. */		\
> > +	/* Verify all bytes overwritten with FILL_BYTE. */	\
> >  	for (sum = 0, i = 0; i < target_size; i++)		\
> > -		sum += (check_buf[i] != 0xFF);			\
> > +		sum += (check_buf[i] != FILL_BYTE);		\
> >  	/* Clear entire check buffer for later bit tests. */	\
> >  	memset(check_buf, 0x00, sizeof(check_buf));		\
> >  	/* Extract stack-defined variable contents. */		\
> > @@ -222,7 +231,8 @@ static noinline void test_ ## name (struct kunit *test)		\
> >  	 * possible between the two leaf function calls.	\
> >  	 */							\
> >  	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
> > -			    "leaf fill was not 0xFF!?\n");	\
> > +			    "leaf fill was not 0x%02X!?\n",	\
> > +			    FILL_BYTE);				\
> 
>   	KUNIT_ASSERT_EQ_MSG(test, sum, 0,			\
>  -			    "leaf fill was not 0xFF!?\n");	\
>  +			    "leaf fill was not 0x%02X!??!?!?!?!?!?!?!\n",	\
>  +			    FILL_BYTE);				\

OMGWTFBBQ!!

> 
> >  								\
> >  	/* Validate that compiler lined up fill and target. */	\
> >  	KUNIT_ASSERT_TRUE_MSG(test,				\
> > @@ -234,9 +244,9 @@ static noinline void test_ ## name (struct kunit *test)		\
> >  		(int)((ssize_t)(uintptr_t)fill_start -		\
> >  		      (ssize_t)(uintptr_t)target_start));	\
> >  								\
> > -	/* Look for any bytes still 0xFF in check region. */	\
> > +	/* Validate check region has no FILL_BYTE bytes. */	\
> >  	for (sum = 0, i = 0; i < target_size; i++)		\
> > -		sum += (check_buf[i] == 0xFF);			\
> > +		sum += (check_buf[i] == FILL_BYTE);		\
> >  								\
> >  	if (sum != 0 && xfail)					\
> >  		kunit_skip(test,				\
> > @@ -271,12 +281,12 @@ static noinline int leaf_ ## name(unsigned long sp, bool fill,	\
> >  	 * stack frame of SOME kind...				\
> >  	 */							\
> >  	memset(buf, (char)(sp & 0xff), sizeof(buf));		\
> > -	/* Fill variable with 0xFF. */				\
> > +	/* Fill variable with FILL_BYTE. */			\
> >  	if (fill) {						\
> >  		fill_start = &var;				\
> >  		fill_size = sizeof(var);			\
> >  		memset(fill_start,				\
> > -		       (char)((sp & 0xff) | forced_mask),	\
> > +		       FILL_BYTE & forced_mask,			\
> >  		       fill_size);				\
> >  	}							\
> >  								\
> > @@ -469,7 +479,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
> >  			fill_start = &var;
> >  			fill_size = sizeof(var);
> >  
> > -			memset(fill_start, forced_mask | 0x55, fill_size);
> > +			memset(fill_start, (forced_mask | 0x55) & FILL_BYTE, fill_size);
> >  		}
> >  		memcpy(check_buf, target_start, target_size);
> >  		break;
> > @@ -480,7 +490,7 @@ static int noinline __leaf_switch_none(int path, bool fill)
> >  			fill_start = &var;
> >  			fill_size = sizeof(var);
> >  
> > -			memset(fill_start, forced_mask | 0xaa, fill_size);
> > +			memset(fill_start, (forced_mask | 0xaa) & FILL_BYTE, fill_size);
> >  		}
> >  		memcpy(check_buf, target_start, target_size);
> >  		break;
> > -- 
> > 2.34.1
> > 
> >
> 
> I don't understand the stack init pattern tendencies enough to give a RB
> but I looked at your patch and it seems to fully replace the fill test
> values from 0xff to 0x99, so if 0x99 is OK then OK.

Yeah, I had to go do some godbolting to remind myself what value were
being used. :)

Thanks for the double-check!

-Kees

> 
> [1]: https://lore.kernel.org/all/20250211003136.2860503-3-kees@kernel.org/
> 
> Justin

-- 
Kees Cook
