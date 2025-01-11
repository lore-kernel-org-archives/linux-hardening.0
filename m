Received: from out.smtpout.orange.fr (out-13.smtpout.orange.fr [193.252.22.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181A153803;
	Sat, 11 Jan 2025 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736618826; cv=none; b=oX902Tr5Vf/KkoidRRRilSmc/ek/XkTZTo9MjcfVEIA/Mwo46zTbAR+MkEnkBuenOUvQa+nf03PM9GID9hJUgIBTJNKW57zHu5MvWHeepdDIWXm1skLhF9VAKq+nCnV8+8oA7J/kBfMFcbmz3Q55IK9Adhr3j1s2M4ZrpHrVCjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736618826; c=relaxed/simple;
	bh=OVK9SjWXpGZvw9hGbObnBv3+rekvaJSPYHtN9w2oxMQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pw+DOVqy+g5w9McAA8Uw8iqy7Hr3lVKTyGE8X8YqZaI6O86bXCH1NDcBEm1GL+HBU81ZsmseBsCIurqMeR0cOC/AEvz2Kzg3TgZHL5uwkjvIOfc9mWRtsPCN/BPPDE3i0vnyos2jNxKwH75OwoeSscfO1GddWrwVQ1GkyidOjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=I1wJFUZU; arc=none smtp.client-ip=193.252.22.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="I1wJFUZU"
Received: from [172.16.82.72] ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id Wfrbt1Qp809tEWfrotXeNr; Sat, 11 Jan 2025 19:05:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1736618751;
	bh=oLX8h4gOkJP1CaxpXBjOQxOK8825Z4ZZC430REsD5QA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=I1wJFUZUT5kxaQ4+ERZJ3yU8Ezs+VJZgWgHi7ViktJMz6Sjr5RWAc4MNZ/usFm6Dm
	 PFRXdByEqzJCk3kGwMCWlY0kIzRQwaBrCyqCdKndx3aTDGsDLYQEJGNfTVn63Kv/dq
	 YzXGM5TL9LMxZiCrOTjan+zkEIJeWHgX5/YDu94JMKnf8FW5Fn672cTmnACdlUswwi
	 MKAvbeeFKeui3135PVcUJNMGPF4/pyq19a1468UTJIufCthnM5a+S9KjsbosrbVAQ0
	 sTOMNRYYP5wyysCLdVDp2kY4c3Zzm3RCGXJdPKdCXVSVI4UWzsmbUMm1mOD4NATey9
	 nZR5dtF/osybA==
X-ME-Helo: [172.16.82.72]
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Sat, 11 Jan 2025 19:05:51 +0100
X-ME-IP: 124.33.176.97
Message-ID: <f0bef267-b9e2-4d7a-8a2f-77eb6fcc5235@wanadoo.fr>
Date: Sun, 12 Jan 2025 03:05:34 +0900
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fortify: turn strlen() into an inline function using
 __builtin_constant_p()
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 David Laight <david.laight@aculab.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20250108-strlen_use_builtin_constant_p-v1-1-611b52e80a9f@wanadoo.fr>
 <202501081331.E4B6DF747@keescook>
 <CAMZ6RqJS5FwuBUdvVdXoZj6wZOJz8Nao4FzSzCK1VtbNF41sMw@mail.gmail.com>
 <CAMZ6RqJbinVpsGf6ADUtQTYPRRQN=D8Ne_n6pHtDUPXxED5ZvQ@mail.gmail.com>
 <20250111165844.6d95600f@pumpkin>
Content-Language: en-US
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Autocrypt: addr=mailhol.vincent@wanadoo.fr; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 LFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI+wrIEExYKAFoC
 GwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQTtj3AFdOZ/IOV06OKrX+uI
 bbuZwgUCZx41XhgYaGtwczovL2tleXMub3BlbnBncC5vcmcACgkQq1/riG27mcIYiwEAkgKK
 BJ+ANKwhTAAvL1XeApQ+2NNNEwFWzipVAGvTRigA+wUeyB3UQwZrwb7jsQuBXxhk3lL45HF5
 8+y4bQCUCqYGzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrbYZzu0JG5w8gxE6EtQe6LmxKMqP6E
 yR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDldOjiq1/riG27mcIFAmceMvMCGwwF
 CQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8VzsZwr/S44HCzcz5+jkxnVVQ5LZ4B
 ANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <20250111165844.6d95600f@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/01/2025 at 01:58, David Laight wrote:
> On Sat, 11 Jan 2025 23:40:41 +0900
> Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> 
>> On Thu. 9 Jan 2025 at 16:52, Vincent Mailhol <mailhol.vincent@wanadoo.fr> wrote:
> ...
>> Actually, I did more investigation and it is working for some strange
>> reasons. Whenever the argument of a function named strlen() is a
>> compile time constant, the compiler (both GCC and clang) will replace
>> it with the string length on the argument, even if strlen() is
>> programmed to return something else:
>>
>>   https://godbolt.org/z/nK4b3fnM7
>>
>> So it is only working because the compiler uses its builtin strlen()
>> instead of the function we provided.
> 
> It depends on whether -ffreestanding is set.
> If not set gcc/clang assume a lot of the basic libc functions have their expected
> behaviour.

Thanks! This rings a bell.

More precisely, rather than -ffreestanding, it depends on -fno-builtin
(which is implied by -ffreestanding). But some architectures do not
provide these flags. Most famously, x86-64 has neither of -fno-builtin
nor -ffreestanding c.f.:


https://lore.kernel.org/all/20220306171009.1973074-1-mailhol.vincent@wanadoo.fr/T/#u

(above thread is a bit old, but I did a make V=1 to confirm that the
flags are still missing as of today).

And with either of -fno-builtin or -ffreestanding, the strlen() inline
function doesn't work anymore as a static initializer (at least it
didn't work in my tests on godbolt).

So now, I am convinced that turning this strlen() in a function was a
bad idea. I am glad I removed it in v2.


Yours sincerely,
Vincent Mailhol

