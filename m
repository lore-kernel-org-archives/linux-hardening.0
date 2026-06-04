Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3860A37CD32;
	Thu,  4 Jun 2026 06:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780554759; cv=none; b=pJHM0hOtsDnvrZ7dhakC5sp+0ottRLeqSK28uUZtpLxlAUvuJo7Ez6/MF6w9DA6OQpZmg9Zh1501GVfg/cvJAmq+QY+PlN9bijPaKVgwnycTrM0wXvoomGXscWbWK579NjXM/RDH+B6nSvOrdraEEk1l8Bs+7kLvGL+Dxjc1ocY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780554759; c=relaxed/simple;
	bh=vjMpFrdhsF3cvdDr1HG4s6q+f0tZYlJsrp9/HJytIH4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=m3f1syU8mmFcHxu9ywjOS3EdLUj15MZYXoJ+h6kQPxnpsBzz37s59NywlGPQoNgU/QDkSVUY/Q42xsV6szwetZOh5c/MLKxWBdZAVovnQtZU721uV3n8I2SJkVPjY/V5F301sTnZGHJseKiXe1uUJZJ7hrXXFmuNdgZz6f40LoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaN0PPqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaN0PPqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAC11F00893;
	Thu,  4 Jun 2026 06:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780554757;
	bh=dV5W26DQiOuq9I4AtWSX96niq6SakPqediiwTnHhLTs=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=MaN0PPqoo5zXDbsRVW1WygBCImFC6GmqkL/UKgBE0LQU2e1Hmajfm8fTTLra0AR4z
	 FjeWyG1tZ0NoXSBhZ64ZegYhot2/5+01WQswVndpHUFuYm2PgCKwIWWmsDqxysx1XK
	 kQ55FjWlvLMEJntuOBx2qlYu1j9T4vUXs7VGlT/NnA+5EEW8ONy9w097Td/RRHXwHi
	 /boEm+T268ZJGkLCK51YOpbCtYdKd+VCwBLB/wC9qP11C8FBq5zuF96xpo19EoclUe
	 QLn5W5M2BKT1nufEY/i0rydIHhUI6MeNfdikDWBnGfUZprHymbxy2oQqqthQhxu9qf
	 HNnW7AfKfe3Gg==
Message-ID: <19579b2b-3f08-435a-b37e-16adb1f483b1@kernel.org>
Date: Thu, 4 Jun 2026 08:32:34 +0200
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPICA: Replace strncpy() with strscpy_pad() in
 acpi_ut_safe_strncpy()
From: Jiri Slaby <jirislaby@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Kees Cook <kees@kernel.org>
Cc: Robert Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 acpica-devel@lists.linux.dev, linux-hardening@vger.kernel.org
References: <20260323172451.work.079-kees@kernel.org>
 <CAJZ5v0hOS7j2f-wkmvarULCS-1+Zio2hOz2ExMvFXN61OPv_tQ@mail.gmail.com>
 <405e97ae-72a1-4086-bef3-cf462619f661@kernel.org>
 <79e9e913-0fb1-4110-804b-c3b5d0edafe4@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <79e9e913-0fb1-4110-804b-c3b5d0edafe4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Ping?

On 29. 05. 26, 9:24, Jiri Slaby wrote:
> On 29. 05. 26, 9:20, Jiri Slaby wrote:
>> On 23. 03. 26, 18:31, Rafael J. Wysocki wrote:
>>> On Mon, Mar 23, 2026 at 6:24 PM Kees Cook <kees@kernel.org> wrote:
>>>>
>>>> Replace the deprecated[1] strncpy() with strscpy_pad() in
>>>> acpi_ut_safe_strncpy().
>>>>
>>>> The function is a "safe strncpy" wrapper that does
>>>> strncpy(dest, source, dest_size) followed by manual NUL-termination
>>>> at dest[dest_size - 1]. strscpy_pad() is a direct replacement: it
>>>> NUL-terminates, zero-pads the remainder, and the manual termination
>>>> is no longer needed.
>>>>
>>>> All callers pass NUL-terminated source strings (C string literals,
>>>> __FILE__ via ACPI_MODULE_NAME, or user-provided filenames that have
>>>> already been validated). The destinations are fixed-size char arrays
>>>> in ACPICA internal structures (allocation->module, aml_op_name,
>>>> acpi_gbl_db_debug_filename), all consumed as C strings.
>>>>
>>>> No behavioral change: strscpy_pad() produces identical output to
>>>> strncpy() + manual NUL-termination for NUL-terminated sources that
>>>> are shorter than dest_size. For sources longer than dest_size,
>>>> strncpy() wrote dest_size non-NUL bytes then the manual termination
>>>> overwrote the last byte with NUL; strscpy_pad() writes dest_size-1
>>>> bytes plus NUL: same result.
>>>>
>>>> Link: https://github.com/KSPP/linux/issues/90 [1]
>>>> Signed-off-by: Kees Cook <kees@kernel.org>
>>>> ---
>>>> This touches the ACPICA component shared with the upstream ACPICA
>>>> project (https://github.com/acpica/acpica), where the function
>>>> is named AcpiUtSafeStrncpy(). The upstream codebase uses its own
>>>> platform abstraction layer (acenv.h/acgcc.h) where I've mapped various
>>>> kernel APIs before like ACPI_FLEX_ARRAY and similar helpers. However,
>>>> acpi_ut_safe_strncpy() is an explicit function implementation rather
>>>> than a macro mapping, so the approach for upstreaming this change to
>>>> ACPICA is not clear. What's the best way to land this?
>>>
>>> I can apply this directly, it shouldn't be a major problem for porting
>>> patches from the upstream.
>>
>> As I reported in https://github.com/acpica/acpica/issues/1158 (but got 
>> no reply), this patch breaks build of acpica against 7.1-rc*:
>>  > ../../../../../drivers/acpi/acpica/utnonansi.c:171:9: error: 
>> implicit declaration of function ‘strscpy_pad’ [-Wimplicit-function- 
>> declaration]
>>
>> Is strscpy_pad() supposed to be emulated in acpica?
> 
> No, I misread the log, it's the in-kernel acpidump failing to build:
> 
> ~/linux/tools/power/acpi/tools/acpidump> make
>    MKDIR    include
>    CP       include
>    CC       tools/acpidump/apdump.o
>    CC       tools/acpidump/apfiles.o
>    CC       tools/acpidump/apmain.o
>    CC       tools/acpidump/osunixdir.o
>    CC       tools/acpidump/osunixmap.o
>    CC       tools/acpidump/osunixxf.o
>    CC       tools/acpidump/tbprint.o
>    CC       tools/acpidump/tbxfroot.o
>    CC       tools/acpidump/utascii.o
>    CC       tools/acpidump/utbuffer.o
>    CC       tools/acpidump/utcksum.o
>    CC       tools/acpidump/utdebug.o
>    CC       tools/acpidump/utexcep.o
>    CC       tools/acpidump/utglobal.o
>    CC       tools/acpidump/uthex.o
>    CC       tools/acpidump/utmath.o
>    CC       tools/acpidump/utnonansi.o
> ../../../../../drivers/acpi/acpica/utnonansi.c: In function 
> ‘acpi_ut_safe_strncpy’:
> ../../../../../drivers/acpi/acpica/utnonansi.c:171:9: error: implicit 
> declaration of function ‘strscpy_pad’ [-Wimplicit-function-declaration]
>    171 |         strscpy_pad(dest, source, dest_size);
>        |         ^~~~~~~~~~~
> make: *** [../../Makefile.rules:25: /home/xslaby/linux/tools/power/acpi/ 
> tools/acpidump/utnonansi.o] Chyba 1
> 
>>>> (This is one of the last users of strncpy in the kernel.)
>>>> ---
>>>>   drivers/acpi/acpica/utnonansi.c | 3 +--
>>>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/ 
>>>> utnonansi.c
>>>> index ff0802ace19b..3a7952be6545 100644
>>>> --- a/drivers/acpi/acpica/utnonansi.c
>>>> +++ b/drivers/acpi/acpica/utnonansi.c
>>>> @@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char 
>>>> *source, acpi_size dest_size)
>>>>   {
>>>>          /* Always terminate destination string */
>>>>
>>>> -       strncpy(dest, source, dest_size);
>>>> -       dest[dest_size - 1] = 0;
>>>> +       strscpy_pad(dest, source, dest_size);
>>>>   }
>>>>
>>>>   #endif
>>>> -- 
>>>
>>
>> thanks,
> 

-- 
js
suse labs

