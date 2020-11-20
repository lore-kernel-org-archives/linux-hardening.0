Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B66DC56201
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AADB12245F
	for <linux-hardening@archiver.kernel.org>; Fri, 20 Nov 2020 18:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="OB69uT03"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgKTSuM (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 20 Nov 2020 13:50:12 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:30038 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727880AbgKTSuM (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 20 Nov 2020 13:50:12 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKIjK1T014077;
        Fri, 20 Nov 2020 10:50:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pfpt0220;
 bh=2Q+/Lc7L9HQ0KAAyRR4rlh48QHiyoVhXquehjGB4IYU=;
 b=OB69uT03ShtkRsi1S3WKlFV2xsMMhKw+QCmgIoiutjQVjKHDX80i3agBOY9gyS1PboIA
 OMv1eg26GTiy5+oLfUygpU+4BT5GaX5SczWZaLlhUOre6yd9akeYoymp36x/7UFt8S42
 u6zDKoVLEuQVn1y/Fa0x1wNde0LQ4TT+UCTGqV/dcTd5Z1yCesd3UOaj69PuDSmm4lIy
 /uoxn57OvA+TDNAyuhW+ksWqCQgr6wnkURhyX/JMVzvrIEnVb3K0s8mefXU594fzHvi3
 KnJwqCt+QdQdtumt4dOvpfG5CHLg4YLgqwE+trfosrsOw4mprJczKyi4R8q+o8epsnMi OA== 
Received: from sc-exch01.marvell.com ([199.233.58.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 34xbeyhqem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 10:50:10 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 20 Nov
 2020 10:50:09 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 20 Nov
 2020 10:50:09 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 20 Nov 2020 10:50:09 -0800
Received: from [10.193.39.169] (NN-LT0019.marvell.com [10.193.39.169])
        by maili.marvell.com (Postfix) with ESMTP id 2F4FD3F7044;
        Fri, 20 Nov 2020 10:50:06 -0800 (PST)
Subject: Re: [EXT] [PATCH 018/141] qed: Fix fall-through warnings for Clang
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
CC:     GR-everest-linux-l2 <GR-everest-linux-l2@marvell.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <35915deb94f9ad166f8984259050cfadd80b2567.1605896059.git.gustavoars@kernel.org>
From:   Igor Russkikh <irusskikh@marvell.com>
Message-ID: <9bcfa09c-dd8d-f879-4762-1b88779fa397@marvell.com>
Date:   Fri, 20 Nov 2020 21:50:06 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <35915deb94f9ad166f8984259050cfadd80b2567.1605896059.git.gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_12:2020-11-20,2020-11-20 signatures=0
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 20/11/2020 9:26 pm, Gustavo A. R. Silva wrote:
> External Email
> 
> ----------------------------------------------------------------------
> In preparation to enable -Wimplicit-fallthrough for Clang, fix multiple
> warnings by explicitly adding a couple of break statements instead of
> just letting the code fall through to the next case.
> 
> Link:
> https://urldefense.proofpoint.com/v2/url?u=https-3A__github.com_KSPP_linux
> _issues_115&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=GtqbaEwqFLiM6BiwNMdKmpXb5o
> up1VLiSIroUNQwbYA&m=6E7IvGvqcEGj8wEOVoN1BySZhGUVECVTBJCmNiRsHUw&s=J1SWrfEL
> erJOzUlJdD_S5afGaZosmVP8lyKsu9DTULw&e= 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Igor Russkikh <irusskikh@marvell.com>

Thanks,
  Igor
