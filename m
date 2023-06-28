Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C55EB64D7
	for <linux-hardening@archiver.kernel.org>; Wed, 28 Jun 2023 20:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232006AbjF1UPr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjF1UPQ (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Wed, 28 Jun 2023 16:15:16 -0400
Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806E1FF5
        for <linux-hardening@vger.kernel.org>; Wed, 28 Jun 2023 13:15:13 -0700 (PDT)
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
        by cmsmtp with ESMTP
        id EZFgqzImPWU1cEbZHqpF3V; Wed, 28 Jun 2023 20:15:12 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id EbZGqkztC3pDSEbZHqecd5; Wed, 28 Jun 2023 20:15:11 +0000
X-Authority-Analysis: v=2.4 cv=Tv31ORbh c=1 sm=1 tr=0 ts=649c94cf
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=PtVJBk4Srns10J10ZCQA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ql0YnZ/hm7SjAddMwZMN2OCRFvLEYjNTsWCj2y8mpk0=; b=ZXuRDz57bO5v6SPpzm/WePFb30
        U4SYPEUCNE6+sJF0IjEvhoOFVeJXFVB2n7XE9Znvh1osuk4SQ53N4QlRnR8roLBQ6DS727aKirLNU
        uE0C1Md9xsPQosYtTeVQAEAGsn8cz7qZXOWLFMpKovdONKJH01p0zE2Uxzi49McU1bMb4yi4NdAmc
        GlBpC7fHd6Dq/9dZUIcWUiF9w8UtXUjYJC80rGv5RqpjW2I0UPH5f9YeCvt2vfAW0BRlyfLhoy1Xj
        StSF17oMwSYG6wAAfvDZVFhIkEG3SRPwmsKWtp/GAl6w9Xq/mrLdDVmJXRcdAAelDvXcjDFJyEzt6
        /beNesfg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:55090 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qEbZG-000Ofy-1E;
        Wed, 28 Jun 2023 15:15:10 -0500
Message-ID: <62386518-4123-db1f-4656-6b4ea509f5b1@embeddedor.com>
Date:   Wed, 28 Jun 2023 14:16:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 00/10][next] scsi: aacraid: Replace one-element arrays
 with flexible-array members
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1687974498.git.gustavoars@kernel.org>
 <202306281307.BB7B4369F@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202306281307.BB7B4369F@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qEbZG-000Ofy-1E
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:55090
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 1
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFNylcZaO6HtqbWpoUEGk48y9SpjjIjBkWmKKskzGh9ZAlI1KBxpvLEO5kD8LrpnmKubXLz8N5uf7l8dvQZ41a0ckGZLLPQHwWh63W8DHR+m6fZrO8CW
 hCnSb7KR7svbboK35QktlxJ7VlQYUZZFGxTjqMCD37CnnVQuwxbNfR9vHd+aO81BQVfoJRWtGBKQlUCP3/8eJfaBy85NvLigQMTSKgbDt/drZIZ8Z1iyCW6r
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org



On 6/28/23 14:08, Kees Cook wrote:
> On Wed, Jun 28, 2023 at 11:53:45AM -0600, Gustavo A. R. Silva wrote:
>> This series aims to replace one-element arrays with flexible-array
>> members in multiple structures in drivers/scsi/aacraid/aacraid.h.
>>
>> This helps with the ongoing efforts to globally enable -Warray-bounds
>> and get us closer to being able to tighten the FORTIFY_SOURCE routines
>> on memcpy().
>>
>> These issues were found with the help of Coccinelle and audited and fixed,
>> manually.
>>
>> Link: https://github.com/KSPP/linux/issues/79
>>
>> Gustavo A. R. Silva (10):
>>    scsi: aacraid: Replace one-element array with flexible-array member
>>    scsi: aacraid: Use struct_size() helper in aac_get_safw_ciss_luns()
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct aac_aifcmd
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct user_sgmapraw
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct sgmapraw
>>    scsi: aacraid: Use struct_size() helper in code related to struct
>>      sgmapraw
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct user_sgmap64
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct sgmap
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct sgmap64
>>    scsi: aacraid: Replace one-element array with flexible-array member in
>>      struct user_sgmap
> 
> I'd like to reorganize this series so that all the conversions are
> first, and then struct_size() additions are at the end. That way, if
> desired, the conversions can land as fixes to turn the Clang builds
> green again.
> 

OK; I can make that happen. :)

--
Gustavo
