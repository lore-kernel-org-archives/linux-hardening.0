Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD52C433E9
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:34:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A50E065026
	for <linux-hardening@archiver.kernel.org>; Fri,  5 Mar 2021 08:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbhCEIeW (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 5 Mar 2021 03:34:22 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:12060 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229642AbhCEIdv (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 5 Mar 2021 03:33:51 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1258WELI002930;
        Fri, 5 Mar 2021 09:33:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=J/LswseSQK9Z1SiYQbprQ/CvYEnximafUDZppa60bLA=;
 b=a7IgNkFBnfH3c0FFQlgVlU9jBFAfoPzqmiD6+hprrnke+Rz7f7UVMG2vFF0sjI0fAnwD
 7M57o8DZxa6NinC5kNTuFgU92weFrlTeD3m5YSBxgJq9wACHnVAflub7fMdNowGpc0pv
 T5ZJrgm9dZd+IuJnVJvYGPwRk1lpLkI27O8XsiswOal32eYBSqyokZVcWIlSYB5a1wo9
 4t4MKi+UOozimEhm6+QxKwSgFYZz0kt00KvbbwaIBOvk5owujv3V0kFPhW6hPpSAoZ30
 x1cdVu/FE0A9gNR/Zb3AGKieNn0WTyHfKNVUOAtkp1aas+Rq3EiQBr9g5/kbY2A75O0p /g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 36yfdymtra-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 05 Mar 2021 09:33:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 53B2B10002A;
        Fri,  5 Mar 2021 09:33:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31BBF22B9BC;
        Fri,  5 Mar 2021 09:33:26 +0100 (CET)
Received: from [10.48.0.224] (10.75.127.49) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Mar
 2021 09:33:25 +0100
Subject: Re: [Linux-stm32] [PATCH v2][next] mtd: rawnand: stm32_fmc2: Fix
 fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20210305080905.GA135306@embeddedor>
From:   Christophe Kerello <christophe.kerello@foss.st.com>
Message-ID: <35bc7c3d-885a-f723-3849-45c0e46a8ef7@foss.st.com>
Date:   Fri, 5 Mar 2021 09:33:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210305080905.GA135306@embeddedor>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-05_04:2021-03-03,2021-03-05 signatures=0
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

Hi Gustavo,

On 3/5/21 9:09 AM, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a couple
> of warnings by explicitly adding a couple of fallthrough pseudo-keywords
> instead of letting the code fall through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
> Changes in v2:
>   Make use of a break statement instead of fallthrough for consistency.
>   Link: https://lore.kernel.org/lkml/20201123093347.719a77cf@xps13/
> 
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 550bda4d1415..1c277fbb91f2 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -531,6 +531,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
>   		switch (b % 4) {
>   		case 2:
>   			bit_position += shifting;
> +			break;
>   		case 1:
>   			break;
>   		default:
> @@ -546,6 +547,7 @@ static int stm32_fmc2_nfc_ham_correct(struct nand_chip *chip, u8 *dat,
>   		switch (b % 4) {
>   		case 2:
>   			byte_addr += shifting;
> +			break;
>   		case 1:
>   			break;
>   		default:
> 

Reviewed-by: Christophe Kerello <christophe.kerello@foss.st.com>

Regards,
Christophe Kerello.
