Return-Path: <linux-hardening-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEAFC61DA4
	for <linux-hardening@archiver.kernel.org>; Sat,  4 Feb 2023 19:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbjBDTnv (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Sat, 4 Feb 2023 14:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjBDTnu (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Sat, 4 Feb 2023 14:43:50 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9ACCD1DB86
        for <linux-hardening@vger.kernel.org>; Sat,  4 Feb 2023 11:43:48 -0800 (PST)
Received: (qmail 603745 invoked by uid 1000); 4 Feb 2023 14:43:47 -0500
Date:   Sat, 4 Feb 2023 14:43:47 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Kees Cook <keescook@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] USB: ene_usb6250: Allocate enough memory for full object
Message-ID: <Y961c1/JIkDUqMbC@rowland.harvard.edu>
References: <20230204183546.never.849-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230204183546.never.849-kees@kernel.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org

On Sat, Feb 04, 2023 at 10:35:46AM -0800, Kees Cook wrote:
> The allocation of PageBuffer is 512 bytes in size, but the dereferencing
> of struct ms_bootblock_idi (also size 512) happens at a calculated offset
> within the allocation, which means the object could potentially extend
> beyond the end of the allocation. Avoid this case by just allocating
> enough space to catch any accesses beyond the end. Seen with GCC 13:

In principle, it would be better to add a runtime check for overflow.  
Doing it this way means that the code could read an invalid value.

In fact, I get the impression that this code tries to load a data 
structure which might straddle a page boundary by reading in just the 
first page.  Either that, or else EntryOffset is always a multiple of 
512 so the error cannot arise.

In any event, it's doubtful that there are very many devices of this 
sort still in use, so it probably doesn't matter.

Alan Stern

> 
> ../drivers/usb/storage/ene_ub6250.c: In function 'ms_lib_process_bootblock':
> ../drivers/usb/storage/ene_ub6250.c:1050:44: warning: array subscript 'struct ms_bootblock_idi[0]' is partly outside array bounds of 'unsigned char[512]' [-Warray-bounds=]
>  1050 |                         if (le16_to_cpu(idi->wIDIgeneralConfiguration) != MS_IDI_GENERAL_CONF)
>       |                                            ^~
> ../include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
>    37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>       |                                                   ^
> ../drivers/usb/storage/ene_ub6250.c:1050:29: note: in expansion of macro 'le16_to_cpu'
>  1050 |                         if (le16_to_cpu(idi->wIDIgeneralConfiguration) != MS_IDI_GENERAL_CONF)
>       |                             ^~~~~~~~~~~
> In file included from ../drivers/usb/storage/ene_ub6250.c:5:
> In function 'kmalloc',
>     inlined from 'ms_lib_process_bootblock' at ../drivers/usb/storage/ene_ub6250.c:942:15:
> ../include/linux/slab.h:580:24: note: at offset [256, 512] into object of size 512 allocated by 'kmalloc_trace'
>   580 |                 return kmalloc_trace(
>       |                        ^~~~~~~~~~~~~~
>   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~
> 
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-usb@vger.kernel.org
> Cc: usb-storage@lists.one-eyed-alien.net
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/usb/storage/ene_ub6250.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/storage/ene_ub6250.c b/drivers/usb/storage/ene_ub6250.c
> index 6012603f3630..97c66c0d91f4 100644
> --- a/drivers/usb/storage/ene_ub6250.c
> +++ b/drivers/usb/storage/ene_ub6250.c
> @@ -939,7 +939,7 @@ static int ms_lib_process_bootblock(struct us_data *us, u16 PhyBlock, u8 *PageDa
>  	struct ms_lib_type_extdat ExtraData;
>  	struct ene_ub6250_info *info = (struct ene_ub6250_info *) us->extra;
>  
> -	PageBuffer = kmalloc(MS_BYTES_PER_PAGE, GFP_KERNEL);
> +	PageBuffer = kzalloc(MS_BYTES_PER_PAGE * 2, GFP_KERNEL);
>  	if (PageBuffer == NULL)
>  		return (u32)-1;
>  
> -- 
> 2.34.1
> 
