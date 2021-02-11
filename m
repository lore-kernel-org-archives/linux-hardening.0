Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B97FC433E6
	for <linux-hardening@archiver.kernel.org>; Thu, 11 Feb 2021 11:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5076064D73
	for <linux-hardening@archiver.kernel.org>; Thu, 11 Feb 2021 11:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhBKLJu (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 11 Feb 2021 06:09:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53858 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhBKLHm (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 11 Feb 2021 06:07:42 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BB63cP128023;
        Thu, 11 Feb 2021 11:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=GiTaMAbIRvqIBQ+RpjfDs/lcGV/8NbrZwq2WqxCkbzA=;
 b=myFWP82pozcA3AqWRl9lpiwiisN+dXkaviUQjJ1reVnjNIrcbzdkEHDVnoZZLFy5jCjY
 Pe0w0jWXi1TLpJiTcDuQzfkTLmcCPor3tNKIOmysMKNOI90WmR179yXs9cXv0jo3zi8L
 xiRyaARZnz0GfSByLxhqZfYBoQk0OdsbSdOrpBVKvU72eeChs0qE2grfz1oxWK+4oC5h
 X9E2uRPuCEzBhpdfiC0SG2WSv00lqf1X+GpeFvVs/5Mdtut48zSsQhArJdP00elcvpv5
 B4yA0bnBX4NlkPtmDjVZCt7tGEL5meDLvw56QuIx7EeJ1rJ4Cc8Gsc6TxtmxH6GUhU/u +A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 36m4upwjpk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 11:06:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11BB5XVQ033690;
        Thu, 11 Feb 2021 11:06:42 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 36j513x5d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Feb 2021 11:06:41 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 11BB6fSS024277;
        Thu, 11 Feb 2021 11:06:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Feb 2021 03:06:40 -0800
Date:   Thu, 11 Feb 2021 14:06:30 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] staging: rtl8723bs: Replace one-element array with
 flexible-array member in struct ndis_80211_var_ie
Message-ID: <20210211110630.GG2696@kadam>
References: <20210210224937.GA11922@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210224937.GA11922@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-IMR: 1
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110100
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9891 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1011
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102110100
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Feb 10, 2021 at 04:49:37PM -0600, Gustavo A. R. Silva wrote:
> There is a regular need in the kernel to provide a way to declare having
> a dynamically sized set of trailing elements in a structure. Kernel code
> should always use “flexible array members”[1] for these cases. The older
> style of one-element or zero-length arrays should no longer be used[2].
> 
> Refactor the code according to the use of a flexible-array member in
> struct ndis_80211_var_ie, instead of a one-element array.
> 
> Also, this helps with the ongoing efforts to enable -Warray-bounds and
> fix the following warnings:
> 
>   CC [M]  drivers/staging/rtl8723bs/core/rtw_wlan_util.o
> In file included from ./drivers/staging/rtl8723bs/include/drv_types.h:20,
>                  from drivers/staging/rtl8723bs/core/rtw_wlan_util.c:9:
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c: In function ‘HT_caps_handler’:
> ./drivers/staging/rtl8723bs/include/basic_types.h:108:11: warning: array subscript 1 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>   108 |  (EF1BYTE(*((u8 *)(__pstart))))
>       |           ^
> ./drivers/staging/rtl8723bs/include/basic_types.h:42:8: note: in definition of macro ‘EF1BYTE’
>    42 |  ((u8)(_val))
>       |        ^~~~
> ./drivers/staging/rtl8723bs/include/basic_types.h:127:4: note: in expansion of macro ‘LE_P1BYTE_TO_HOST_1BYTE’
>   127 |   (LE_P1BYTE_TO_HOST_1BYTE(__pstart) >> (__bitoffset)) & \
>       |    ^~~~~~~~~~~~~~~~~~~~~~~
> ./drivers/staging/rtl8723bs/include/rtw_ht.h:97:55: note: in expansion of macro ‘LE_BITS_TO_1BYTE’
>    97 | #define GET_HT_CAPABILITY_ELE_RX_STBC(_pEleStart)     LE_BITS_TO_1BYTE((_pEleStart)+1, 0, 2)
>       |                                                       ^~~~~~~~~~~~~~~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1104:58: note: in expansion of macro ‘GET_HT_CAPABILITY_ELE_RX_STBC’
>  1104 |   if (TEST_FLAG(phtpriv->stbc_cap, STBC_HT_ENABLE_TX) && GET_HT_CAPABILITY_ELE_RX_STBC(pIE->data)) {
>       |                                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1051:75: warning: array subscript 2 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>  1051 |    if ((pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x3) > (pIE->data[i] & 0x3))
>       |                                                                  ~~~~~~~~~^~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c: In function ‘check_assoc_AP’:
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1606:19: warning: array subscript 4 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>  1606 |      if (pIE->data[4] == 1)
>       |          ~~~~~~~~~^~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1609:20: warning: array subscript 5 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>  1609 |       if (pIE->data[5] & RT_HT_CAP_USE_92SE)
>       |           ~~~~~~~~~^~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1613:19: warning: array subscript 5 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>  1613 |      if (pIE->data[5] & RT_HT_CAP_USE_SOFTAP)
>       |          ~~~~~~~~~^~~
> drivers/staging/rtl8723bs/core/rtw_wlan_util.c:1617:20: warning: array subscript 6 is above array bounds of ‘u8[1]’ {aka ‘unsigned char[1]’} [-Warray-bounds]
>  1617 |       if (pIE->data[6] & RT_HT_CAP_USE_JAGUAR_BCUT) {
>       |           ~~~~~~~~~^~~
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://www.kernel.org/doc/html/v5.9/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/109
> Build-tested-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/lkml/602434b8.jc5DoXJ0bmHoxgIL%25lkp@intel.com/
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks okay to me.  I looked for potential issues with changing the
sizeof the struct but couldn't find any.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter

