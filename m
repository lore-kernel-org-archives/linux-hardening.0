Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E77C433EF
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 20:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0DF604E9
	for <linux-hardening@archiver.kernel.org>; Mon, 25 Oct 2021 20:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237015AbhJYUSC (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Mon, 25 Oct 2021 16:18:02 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5233 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237202AbhJYURx (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Mon, 25 Oct 2021 16:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635192931; x=1666728931;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3Ozvhjgx1+2cTp5cMK3r1EyeG0koD1SSBIpSFhmPJGY=;
  b=evu/T4NJsJGPQuvZHSmxuiTvzJthvKHIqgx5GVHZGvmqC3yAKYNaRanF
   eKy1Pmayaqi6bJyzg/u3AGZtdJfaQIT87HNoOIDdRhX0GnLaWR+YYDqA6
   +G6qMZJJEc7KjowpA8HFXA//hjbSBaGUdteiL47PeUPm/1pnZoVNgWd7Y
   8=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 13:15:31 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 13:15:30 -0700
Received: from [10.110.4.237] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7; Mon, 25 Oct 2021
 13:15:29 -0700
Subject: Re: [PATCH] fortify: Avoid shadowing previous locals
To:     Kees Cook <keescook@chromium.org>
CC:     <linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211025183728.181399-1-quic_qiancai@quicinc.com>
 <202110251232.652ACB6@keescook>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <cd68c514-544d-c29f-d435-78e31f6a173c@quicinc.com>
Date:   Mon, 25 Oct 2021 16:15:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202110251232.652ACB6@keescook>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 10/25/21 3:34 PM, Kees Cook wrote:
> On Mon, Oct 25, 2021 at 02:37:28PM -0400, Qian Cai wrote:
>> __compiletime_strlen macro expansion will shadow p_size and p_len local
>> variables. Just rename those in __compiletime_strlen.
> 
> They don't escape their local context, though, right? i.e. I don't see a
> problem with the existing macro. Did you encounter a specific issue that
> this patch fixes?

Yes, this is pretty minor. There are also some extra compiling warnings (W=2)
from it.

./include/linux/fortify-string.h: In function 'strnlen':

./include/linux/fortify-string.h:17:9: warning: declaration of 'p_size' shadows a previous local [-Wshadow]

   17 |  size_t p_size = __builtin_object_size(p, 1); \

      |         ^~~~~~

./include/linux/fortify-string.h:77:17: note: in expansion of macro '__compiletime_strlen'
   77 |  size_t p_len = __compiletime_strlen(p);

      |                 ^~~~~~~~~~~~~~~~~~~~

./include/linux/fortify-string.h:76:9: note: shadowed declaration is here

   76 |  size_t p_size = __builtin_object_size(p, 1);

      |         ^~~~~~

./include/linux/fortify-string.h:19:10: warning: declaration of 'p_len' shadows a previous local [-Wshadow]

   19 |   size_t p_len = p_size - 1;  \

      |          ^~~~~

./include/linux/fortify-string.h:77:17: note: in expansion of macro '__compiletime_strlen'
   77 |  size_t p_len = __compiletime_strlen(p);

      |                 ^~~~~~~~~~~~~~~~~~~~

./include/linux/fortify-string.h:77:9: note: shadowed declaration is here

   77 |  size_t p_len = __compiletime_strlen(p);

      |         ^~~~~
