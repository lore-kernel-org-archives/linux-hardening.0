Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9434288530;
	Tue,  2 Dec 2025 11:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764673456; cv=none; b=JEadD8EET3tPdBjeJR2TsbIp+KvuhcQrnct5tNix5Zyde/elZoZVDjBg3FpkYxncQOuSpeItWTiCrXTnaycS0kkHHfYP2NMwS7xufLqZagPTFzjI+wakbNly8EBVbkHpeEvS3cEvze6QatTz0aC2bB6BGBJeuoZSPgmR2yDcrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764673456; c=relaxed/simple;
	bh=GaNasTp+kUNzOdLWEZNylyAFWuycCcR1WDHqas1rxf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArH5VUgZDzb+mm7CDPJwr8QjCq8LTdJIXE+W8RTio27jIe4mDthiQswNfnYbwVjdKIIQcRl6cKE8cxQcWuh5RvW5sWYPVNC4fxCDDuVaeyYZiMYoIcX0lnOPvrfkMWmxzHdVym0+V0IbkF/0FffS/Z8mwkpe0V5wh9GSZ6MU56k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 963B5153B;
	Tue,  2 Dec 2025 03:04:05 -0800 (PST)
Received: from [10.1.30.224] (XHFQ2J9959.cambridge.arm.com [10.1.30.224])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 081833F59E;
	Tue,  2 Dec 2025 03:04:10 -0800 (PST)
Message-ID: <684115c9-4ca2-485e-94a4-706d075f3f6e@arm.com>
Date: Tue, 2 Dec 2025 11:04:09 +0000
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 2/2] randomize_kstack: Unify random source across
 arches
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <kees@kernel.org>,
 Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Jeremy Linton <jeremy.linton@arm.com>,
 Catalin Marinas <Catalin.Marinas@arm.com>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-hardening@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
 <20251127105958.2427758-3-ryan.roberts@arm.com>
 <CAMj1kXFY1RXk8T4f46bkm_sr0nJfBoO+ii68JK4+CsRiDwKdCg@mail.gmail.com>
 <9097505d-b18b-4f85-a02c-7f2865ad8bca@arm.com>
 <CAMj1kXHX1W2Kz5NJehtzDhOCKWEd6y1sp8+ViOMHGsq9e8=7Pw@mail.gmail.com>
 <aS6ylpLIyDZOvBDB@J2N7QTR9R3> <7da8d5cc-7b67-4f51-8f09-7ca401d06a3d@arm.com>
 <aS63BeFzDCgkVsNy@J2N7QTR9R3>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <aS63BeFzDCgkVsNy@J2N7QTR9R3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/12/2025 09:53, Mark Rutland wrote:
> On Tue, Dec 02, 2025 at 09:39:40AM +0000, Ryan Roberts wrote:
>> On 02/12/2025 09:35, Mark Rutland wrote:
>>> On Tue, Dec 02, 2025 at 10:15:22AM +0100, Ard Biesheuvel wrote:
>>>> On Mon, 1 Dec 2025 at 19:20, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>> On 28/11/2025 11:01, Ard Biesheuvel wrote:
>>>>>> On Thu, 27 Nov 2025 at 12:00, Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>> diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
>>>>>>> index 089b1432f7e6..83c7e6710f6d 100644
>>>>>>> --- a/include/linux/randomize_kstack.h
>>>>>>> +++ b/include/linux/randomize_kstack.h
>>>>>>> @@ -6,6 +6,7 @@
>>>>>>>  #include <linux/kernel.h>
>>>>>>>  #include <linux/jump_label.h>
>>>>>>>  #include <linux/percpu-defs.h>
>>>>>>> +#include <linux/prandom.h>
>>>>>>>
>>>>>>>  DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>>>>>>>                          randomize_kstack_offset);
>>>>>>> @@ -45,9 +46,13 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
>>>>>>>  #define KSTACK_OFFSET_MAX(x)   ((x) & 0b1111111100)
>>>>>>>  #endif
>>>>>>>
>>>>>>> +static __always_inline u32 get_update_kstack_offset(void)
>>>>>>> +{
>>>>>>> +       return prandom_u32_state(&current->kstack_rnd_state);
>>>>>
>>>>> I've got bot warnings because this is being called from noinstr code. I guess
>>>>> the best option is to just move add_random_kstack_offset() to after
>>>>> instrumentation is enabled for the affected arches.
>>>>
>>>> Just put instrumentation_begin()/instrumentation_end() around the call
>>>> to prandom_u32_state() - that seems to be the common approach for
>>>> punching holes into the 'noinstr' validation.
>>>
>>> That silences the warning, but isn't necessarily safe, so please DO NOT
>>> do that blindly. The instrumentation_{begin,end}() annotations are only
>>> supposed to be used when we know by construction that instrumentation is
>>> safe.
>>>
>>> Generally, if you can move this to after instrumentation is already
>>> enabled, that should be safe, and so that'd be the better approach.
>>>
>>> Ryan, can you share those warnings (e.g. link to those reports)?
>>
>> https://lore.kernel.org/oe-kbuild-all/202511302137.u4iIA2kf-lkp@intel.com/
>> https://lore.kernel.org/oe-kbuild-all/202511302317.BGFIlAYX-lkp@intel.com/
> 
> Cool, so those are __do_fast_syscall_32() and do_syscall_64(), which I'd
> expect (and those are legitimate warnings).
> 
> From a quick scan of v6.18, it looks like arm64, loongarch, powerpc, and
> riscv perform all the necessary entry work before calling
> add_random_kstack_offset(), and we'll need to change:
> 
> * s390's __do_syscall()
> * x86's do_syscall_64()
> * x86's do_int80_syscall_32()
> * x86's __do_fast_syscall_32()

Yup. I'll have a play with inline vs outline. If I go with outline, I'll fix
these sites up.

> 
> Mark.

