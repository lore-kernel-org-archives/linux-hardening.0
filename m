Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA4C433EF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 17:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD61560EFF
	for <linux-hardening@archiver.kernel.org>; Fri, 29 Oct 2021 17:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2RHr (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Fri, 29 Oct 2021 13:07:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:58619 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhJ2RHq (ORCPT <rfc822;linux-hardening@vger.kernel.org>);
        Fri, 29 Oct 2021 13:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635527095;
        bh=UBQu2NaBw0leNJlGUn2ClfwzgV4ttHKz2FJYUhUzXRo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=io0EmqdcFB1d01A6sQpNDNpRpAmDizeHcLp44bv9rv1WULm/MEkwc/U3bsGVCAG/M
         dJKLXUUKOfy9OFzZ5D34GFbRTHd3pM8r1kv3ts1BMWrMdBkfuwNcgh9r9GCl3FUZ4p
         T8KBXx0J502Urj4+fnDLX35Ol0dEV54078rnn7YI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([79.150.72.99]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MC30Z-1mUdjf3SaT-00CUoV; Fri, 29
 Oct 2021 19:04:55 +0200
Date:   Fri, 29 Oct 2021 19:04:52 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Len Baker <len.baker@gmx.com>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmet: prefer flex_array_size and struct_size over open
 coded arithmetic
Message-ID: <20211029170452.GB2124@titan>
References: <20211024172921.4110-1-len.baker@gmx.com>
 <20211027060740.GB9949@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027060740.GB9949@lst.de>
X-Provags-ID: V03:K1:KtOAKC3QeoN2eTs+KoV3lQcpfyIO3RqIyE4fzQLQGs0h+ANU3vW
 ypyFCHXnIH/AY536yHQQZ0tSJc6t8tLoCGFfTawQ7kpLr22hK1zOfATQOQCdtzCFhfvAw1p
 h9+4c43eudVUtDJCakTZyeTJ+wB5Qx4xn3j1yBW8yzZ5OPBeKU6np0Zaz1DN63L587YBdmg
 N99xdXgXUEi+75M0BOKZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:H/LfKFHkclc=:hlvxRFxMJJGxCw1GVEhnU7
 Q+T3PDabx2OGw50mHEkFJzB6crrhmHf/JshrYrV0Wxoa4lN+lgs5D42ZqO3765JgzaZlPVmjs
 LwlleoB9L8gY4qY2enOgeyFfAuHFi89X2DuN/fDADIz3Buti/6AKh8uZnBLG1P5cmKm18aSR/
 7JMHepqBtSd5zssuwDy3uHV22+wKl0v4eeafcUHBwn+cxpYuqCa2MbPsONEpyY1lXMq9SyVb/
 KV1J4+4ZE7olcFEXzvA9KpQKUhCLyG5g9nz3JnWvUz/Nomgul6GQVCIztifBO3tS8j9JPVeQx
 iSRou2+SDD/1rrvN7Shtn6n9ZA5nGglVyjrHez+YNgqP/Xh5ua+nXTFA05U8RZzKekjwnaqwW
 cD4Ro16EqnNRepyDZ8UP599vhEYO0o9TX9Gn81VTJgQzNnC6S+ktIezCiZmlquurZ9cOLlvtD
 N78hjkdVJCrYkD7ywzG3tZezFFFXqU6yv+VEgeDAvEtOKgEB8qRnnmWdmAfK+g7NfFYAKLXM0
 E/tcSthRTewkagbGgy1y5WF9uRwyHzyC6KpwBVX6VNP4ZLqnlBihoBPEifAwOPh89zwmbT3r/
 760pvcjorlIc6I98w61C/yoh9N+S+J6ibEGSCl5hPwwDsZCDJrF23JH5j4qfR1FPlgeKHGXJc
 VosReCJ0eRC7FASgAQv5v87cXgFLGFy9+lfE+NBYxCXeNLYES5ubJ00pNrxzA6+j0FpFemZI7
 fVRoTp6/0FMZGIa0KpBU3mPqa5FpI9EwUbehHvJ2sRLBK9hYOH5DODIbUAGdYmYSrq3m0zz44
 dZm3jzCVaGIM9X0Z4UI/vsMEd/ISdB8RwcT/wXHvVRVoIZO5b25ZJLZWr66S7Rwezv0RDRIaU
 uJbtlyDi6iOZFDdLml54NsyjBBOcgECYrstBsKwDOs+uXtqW8eu29tGfUkI8iR7yLc+0pzRXG
 RRrBNwk1l1cUwIcnZs374/n3vOBDw81IGwVkoEKetPcY87NrcdpO7rPKgUjPZYtTMcamlUDes
 H03EvGiFo/TFyuexWNdMFTDaGSrC1jg196KE3p6GWNBAA9UVIgcBXqIpesabUXgxPvVUdwHHi
 6dDUhbwO50XNCw=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Wed, Oct 27, 2021 at 08:07:40AM +0200, Christoph Hellwig wrote:
> Thanks,
>
> applied to nvme-5.16 with a fixed up subject.

Hi all,

Thanks Sagi, Chaitanya, Gustavo and Christoph.

Regards,
Len
