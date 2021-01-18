Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52AFC433E9
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 18:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0B622D03
	for <linux-hardening@archiver.kernel.org>; Mon, 18 Jan 2021 18:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407549AbhARSXF (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 18 Jan 2021 13:23:05 -0500
Received: from fallback16.mail.ru ([94.100.177.128]:53916 "EHLO
        fallback16.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407503AbhARSXD (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 18 Jan 2021 13:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=IZEh96hRIQ5jVNlBdgLtpLqSWUhVetlx+S6lQeuaIv8=;
        b=NMex6bts2oI6UHDLzVIheyrNt9sJQ8T/7bXuGT51nWEuOjnhBTYOqmcrSqj8SfIjPWIvR0ayEv+4SUbMCcxXDa3pg8ZJWDGq6j7Bm5RSqu9iKmfxPZJWVaYUDczo++sgfsEmxSaeiP4B+WrNbKTxcI5S0PMRRLbK8kFVm78PTfY=;
Received: from [10.161.16.37] (port=54756 helo=smtp63.i.mail.ru)
        by fallback16.i with esmtp (envelope-from <ssuloev@orpaltech.com>)
        id 1l1ZAM-0004u4-DX; Mon, 18 Jan 2021 21:22:14 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=orpaltech.com; s=mailru;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=IZEh96hRIQ5jVNlBdgLtpLqSWUhVetlx+S6lQeuaIv8=;
        b=BXXwoKzmFlsUZvh1KYl/+uidgMIvyIkeJAmqRW8krTJjtvG1UhXhAVmeXlGYppvgunwA65ygh/I99+eQ8+QNzRSEtdjI698D2EvwR6MQCyCHkxYQCyrI0J0fNoYcgdCoLr+9O8oYfGizsl7dc3ztWwco4RM5AB/pWf0SlC2vrK8=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <ssuloev@orpaltech.com>)
        id 1l1Z9V-0002fJ-Gq; Mon, 18 Jan 2021 21:21:22 +0300
Subject: Re: Compilation issue with Linaro ARM toolchain
To:     Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linaro Toolchain Working Group 
        <linaro-toolchain@lists.linaro.org>, keescook@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org
References: <70249918-0081-aef4-0605-85db700aadc5@orpaltech.com>
 <20210118155921.GA462671@xps15>
 <061303A4-51F3-42E0-BCE3-BFAF416D7609@linaro.org>
From:   Sergey Suloev <ssuloev@orpaltech.com>
Organization: ORPALTECH
Message-ID: <8ab4e82f-d2dc-a2e3-6ffe-72433419ad56@orpaltech.com>
Date:   Mon, 18 Jan 2021 21:21:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <061303A4-51F3-42E0-BCE3-BFAF416D7609@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9D0E79FBC973162CD3008320BFA2F4C653BABCE9B72A1DEA600894C459B0CD1B952E5E7EC8866A17A11A9D84F384786D8B71C2206CCE3DF81AF0056C46A67EA41
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A8325FA649D0A450EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637D24CDE3D695BBBC6EA1F7E6F0F101C674E70A05D1297E1BBC6CDE5D1141D2B1C09A43F262B1F751A2085BF6C6C2F2DE6D8B76ECD37234FD39FA2833FD35BB23D9E625A9149C048EE33AC447995A7AD18618001F51B5FD3F9D2E47CDBA5A96583BD4B6F7A4D31EC0BC014FD901B82EE079FA2833FD35BB23D27C277FBC8AE2E8BAA867293B0326636D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EECCD848CCB6FE560CCAA9C333723BB66AD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE386D40F53BA1922956E0066C2D8992A16C4224003CC836476EA7A3FFF5B025636A7F4EDE966BC389F9E8FC8737B5C2249DD7A2359C15937AF089D37D7C0E48F6CCF19DD082D7633A0E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C950FFAD7B4C0E84F43847C11F186F3C5E7DDDDC251EA7DABCC89B49CDF41148FA8EF81845B15A4842623479134186CDE6BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A572373BB21799986EA46884A552204A597DEC41D665009C46D59269BC5F550898D99A6476B3ADF6B47008B74DF8BB9EF7333BD3B22AA88B938A852937E12ACA7538889A5EF59567618E8E86DC7131B365E7726E8460B7C23C
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D344A2E3AE0A8792E69A0D3136D537F0D5465AA03C88B8682A5216F1A4E8C113F7771C3AA979FEB8FEF1D7E09C32AA3244CC5996ADABDCD5DDE7C8B79270C2EE924435BF7150578642FDCA3B3C10BC03908
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojYu4DkwLgf0IcMyZwKX96Hw==
X-Mailru-Sender: C5364AD02485212F08C1E15139291EE952E5E7EC8866A17A11A9D84F384786D8069BFC61DABEEB110841D3AAAB1726C63DDE9B364B0DF289264D2CD8C2503E8C22A194DADEED8EEDCA01A23BA9CD1BE7ED14614B50AE0675
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B40E5D90E44ABF6C6604BA033ECC7B62DEFF58D7CC134EE095049FFFDB7839CE9E3F38DD48A950245D81C21AEF17691CA9BBFFC66FBEEB0C2E1A768DAE1DD44524
X-C1DE0DAB: 0D63561A33F958A51C4A0E2C4F85A5FFC6B024DCF1DF712EE38A2CEF05D0EB3BD59269BC5F550898D99A6476B3ADF6B4886A5961035A09600383DAD389E261318FB05168BE4CE3AF
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdlTFGVPAkz0LcamLqK7CQ1g==
X-Mailru-MI: 800
X-Mras: Ok
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi, Maxim,

thank you for the reply.
Installing libmpc-dev helped.

On 18.01.2021 19:04, Maxim Kuvyrkov wrote:
>> On 18 Jan 2021, at 18:59, Mathieu Poirier <mathieu.poirier@linaro.org> wrote:
>>
>> Adding the Linaro toolchain group mailing list.
>>
>> On Mon, Jan 18, 2021 at 05:49:39PM +0300, Sergey Suloev wrote:
>>> Hi, guys,
>>>
>>> I am having an issue builduing kernel 5.11 (rc4) with Linaro ARM toolchain.
>>> The issue seems to be related to CC plugins sources.
>>> Here is my build log: https://pastebin.com/DTn7Szax. I have never seen this
>>> before with versions 5.10 and below.
> Thanks, Mathieu.
>
> Hi Sergey,
>
> MPC (along with GMP and MPFR) are libraries that GCC and its plugins depend on.  I think, installing libmpc-dev or equivalent should fix the problem; installing an equivalent of “apt build-dep gcc” might be more robust.
>
> Linux kernel has recently relaxed the way it detects support for compiler plugins, so it’s now enabling them more often than before.
>
> Hope this helps,
>
> --
> Maxim Kuvyrkov
> https://www.linaro.org
>
Thanks,
Sergey

