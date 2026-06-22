Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC2C38F227
	for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 08:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116297; cv=none; b=omYNVYXOZz2cTKAf+OlLLsdSA72OiNjwZDEpoLfWEFdD44+bnvGj58SNyuHg4aTG1sLVSBYydW/iJSkoA85+d1FJz/e/n3tWfnJ1wwwT7noBRAKCgYWrTzL80egPQBMXPbmto9qKsBw1DMq4InwEol9ekNDnEPTIBPEYVof+7hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116297; c=relaxed/simple;
	bh=kchaHGbuD3Cp5Gw9qsC+6xIIPUpTFqc4APXbX8vshqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OnpdT3X/gva0VSGEtljhpzYSbyi9KnmWk73Gnhat7Ri+tHT7bT4kY/LsI9DwAuDa6AFnKsfuUysY/So5wY/S7LEcE2XTDb39do6pi8k5E4jWRaW/urWOeuujKpC24Y8r6eTYLrnLyKzh6rnaNGcVCF/YClqiPbp7r5C8SPccHSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZIKY3FhE; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIKY3FhE"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c892a0ef503so2593524a12.2
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jun 2026 01:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782116295; x=1782721095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WnzEGAPdTbj50+aOsUk+pqnINR3riAsvsyCwurmkB1E=;
        b=ZIKY3FhE7Vdg0V153R+/Z1KT05YRo7/p33end/71yv6A4jU7Zp1k3MHUukzYSMZOhG
         p9vbEhF2kfF7x2aRgjYyHADvP0EZ3bfyQjpY5cFbb/CVGNRiJZOnu77Csipri3zoOkrY
         ErCwqyROdHagu0wRu8bpZiIm1tqXXmtLjqlBYpnTScRf//RMJsO/fvMvYOCEZG0yO8Sb
         2ffEJawgG0M0fBCpNGrGicM5kZpoqRndxb9WPd2XwGGleqLUnLJocQ5xHvJAwQrG6iQr
         oHMjAhUqzAfiKKmWhkxGmIL22Bobs29hdLJ5hSne87uWfuPKwr5ybCN7AWqaIBrRn5s0
         5iNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782116295; x=1782721095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnzEGAPdTbj50+aOsUk+pqnINR3riAsvsyCwurmkB1E=;
        b=PLGcLHNJmfgX1nnvZZg/Xj53e8WrznQLPo7x7bohmiHSPs7SNXrKphFTv7/KnF36mh
         UNGHOXuLbJQAfY2y99kEuFJVOdf0+wpQcXF/8FgaLSnITjQu5C7TXE7jKNlFpypEf9X1
         gak/KwZsfOpZNgcxa5/7Tq+AP5kaJvbpdMoUxlNDOCvNGCTs6O9x2XOG2FysO3Xu0ndg
         PuJf7Vkan51iOurrYH+7Yckw/wB9s+MI8KekPEsAwW3ywdhc4GSuvWAmmQ121+597UWe
         TmTTptxNm7M4Bqfg1bRePjIgw7/xrysTQk9HdQC0OKi5SYdEUdbRKQySvCQWUZsLcIu8
         6FMA==
X-Forwarded-Encrypted: i=1; AFNElJ/ReJNJmdDgjz7Tjt9RIr9ixKaYoRtaB94UB/oGHMT8p3gY6Fn+pir6TQKjQy9hDaRD4BWUCGk8b3oPUcIZu+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZGrvC8bH1yV++cNU6Jj2Vz6Zf6XDPyO+KcilIicEaIAsH0Jd
	wY1CD818/PBy43jmLxxkd7k3Vpp6n9eoNMuY/Myii0vJBNDOhcmhiAFP
X-Gm-Gg: AfdE7cmTqDVv+JKogrHLe4SXLyIueQJFYtnCW80I3jtDBP1kMu1ed2nQvT4QJ04+m+e
	lnzn7qKNUYAVLXRgpwy8s5s5PW+q8q6wac5w4pDimbJ96CdoRzKdMmI06/Cr2VDEpbWDuDpBqC1
	KzR8RrXrwu8DxegxRB2bvPmEbshIa5SO3uYTJ/s896DzcXWCcXa80PPpeqR9feZtl/Vp8tx5ejd
	q+tNlSsGB+SPQWRTBzN58Dg/5AChAU7Nw1zSCBdnSz+ZwCeKn7pplY+SpJuo87FRXtrC+o2ne0F
	OOB465bvFz4yw8OlogRyPpcjWk8fuW6c/2RCeE54m0DoKdIfXgKdtC0W4t2JHJnVut3Crq9a2HG
	doQzNQ2ZCocSayhSOdircYO7AejgZczsyu3ww6GibCcOQ9B1Cyt7++m+15VGJDlO5X/FcFDF4MF
	Yo2Tp+3Lv0vVvBc6TmcQzTGLeWLINPe2krxPJMuXAq9AHyA7o5FEQOM1S8orrj7/8/9w3Hu9tgL
	xJX
X-Received: by 2002:a05:6a20:431a:b0:3b4:640e:f6b1 with SMTP id adf61e73a8af0-3bb32914066mr14471224637.10.1782116294931;
        Mon, 22 Jun 2026 01:18:14 -0700 (PDT)
Received: from ?IPV6:2001:fb1:d9:863a:1c8e:6f40:7f4b:ee15? ([2001:fb1:d9:863a:1c8e:6f40:7f4b:ee15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8bc5efcb1csm5846563a12.30.2026.06.22.01.18.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 01:18:14 -0700 (PDT)
Message-ID: <ea5c9577-5d16-435b-9e1c-aa562a1cc6d9@gmail.com>
Date: Mon, 22 Jun 2026 15:18:08 +0700
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Use seq_buf for string concatenation
To: Jori Koolstra <jkoolstra@xs4all.nl>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 shuah@kernel.org, skhan@linuxfoundation.org, me@brighamcampbell.com
References: <20260620175441.223342-1-woradorn.laon@gmail.com>
 <70408559.2499685.1782062190117@kpc.webmail.kpnmail.nl>
Content-Language: en-US
From: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
In-Reply-To: <70408559.2499685.1782062190117@kpc.webmail.kpnmail.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/6/2569 BE 00:16, Jori Koolstra wrote:
> 
>> Op 20-06-2026 19:54 CEST schreef Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>:
>>
>>  
>> In preparation for removing the strlcat API[1],
>> replace the string concatenation logic with a struct seq_buf,
>> which tracks the current position and the remaining space internally.
>>
>> The backing buffer bootup_event_buf allocation is unchanged.
>> Use seq_buf_str() to NUL-terminate before passing to early_enable_events().
>>
>> Link: https://github.com/KSPP/linux/issues/370 [1]
>>
>> Signed-off-by: Woradorn Laodhanadhaworn <woradorn.laon@gmail.com>
>> ---
>>  kernel/trace/trace_events.c | 21 ++++++++++++++++-----
>>  1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index c46e623e7e0d..15164723e028 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/sort.h>
>>  #include <linux/slab.h>
>>  #include <linux/delay.h>
>> +#include <linux/seq_buf.h>
>>  
>>  #include <trace/events/sched.h>
>>  #include <trace/syscall.h>
>> @@ -4501,13 +4502,23 @@ extern struct trace_event_call *__start_ftrace_events[];
>>  extern struct trace_event_call *__stop_ftrace_events[];
>>  
>>  static char bootup_event_buf[COMMAND_LINE_SIZE] __initdata;
> 
> Isn't this now unused?
> 
>> +static struct seq_buf bootup_event_seq;
>> +static bool bootup_event_seq_initialized;
>>  
> 
> I think this can be refactored to avoid the bool. And should bootup_event_seq not be
> __initdata?
> 
>>  static __init int setup_trace_event(char *str)
>>  {
>> -	if (bootup_event_buf[0] != '\0')
>> -		strlcat(bootup_event_buf, ",", COMMAND_LINE_SIZE);
>> +	if (!bootup_event_seq_initialized) {
>> +		seq_buf_init(&bootup_event_seq, bootup_event_buf, COMMAND_LINE_SIZE);
>> +		bootup_event_seq_initialized = true;
>> +	}
>> +
>> +	if (seq_buf_used(&bootup_event_seq) > 0)
>> +		seq_buf_puts(&bootup_event_seq, ",");
>>  
>> -	strlcat(bootup_event_buf, str, COMMAND_LINE_SIZE);
>> +	seq_buf_puts(&bootup_event_seq, str);
>> +
>> +	if (seq_buf_has_overflowed(&bootup_event_seq))
>> +		return -ENOMEM;
>>  
>>  	trace_set_ring_buffer_expanded(NULL);
>>  	disable_tracing_selftest("running event tracing");
>> @@ -4766,7 +4777,7 @@ static __init int event_trace_enable(void)
>>  	 */
>>  	__trace_early_add_events(tr);
>>  
>> -	early_enable_events(tr, bootup_event_buf, false);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), false);
> 
> What if trace_event is empty? Then setup_trace_event does not run AFAIK. See the
> WARN_ON in seq_buf_str too. Have you tested this?
> 
>>  
>>  	trace_printk_start_comm();
>>  
>> @@ -4794,7 +4805,7 @@ static __init int event_trace_enable_again(void)
>>  	if (!tr)
>>  		return -ENODEV;
>>  
>> -	early_enable_events(tr, bootup_event_buf, true);
>> +	early_enable_events(tr, (char *)seq_buf_str(&bootup_event_seq), true);
>>  
>>  	return 0;
>>  }
>> -- 
>> 2.43.0
> 
> Thanks,
> Jori.

Thank you, Jori, for your review. I will send v2.
I tested both empty and non-empty trace_event cases with QEMU, and both now boot successfully. 

The logs below demonstrate this.

Non-empty trace_event:

qemu-system-x86_64 \
    -kernel arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0 trace_event=:mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss trace_event=:mod:rproc_qcom_common" \
    -nographic \
    -m 512M

[    0.082316] Kernel command line: console=ttyS0 trace_event=:mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss trace_event=:mod:rproc_qcom_common
[    0.083324] bootup_event_buf: :mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss
[    0.083413] bootup_event_buf: :mod:rproc_qcom_common,:mod:qrtr,:mod:qcom_aoss,:mod:rproc_qcom_common
[    0.083689] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes

Empty trace_event:

qemu-system-x86_64 \
    -kernel arch/x86/boot/bzImage \
    -initrd initramfs.cpio.gz \
    -append "console=ttyS0" \
    -nographic \
    -m 512M

[    0.085213] Kernel command line: console=ttyS0
[    0.086458] printk: log buffer data + meta data: 262144 + 917504 = 1179648 bytes

Thanks,
Woradorn
